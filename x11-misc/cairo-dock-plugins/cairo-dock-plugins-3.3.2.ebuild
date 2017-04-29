# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_DEPEND="2:2.5"
DISTUTILS_SETUP_FILES=("Dbus/interfaces/bash|setup.py" "Dbus/interfaces/python|setup.py")

inherit distutils-r1 cmake-utils versionator

MY_PN="${PN/plugins/plug-ins}"
MY_PV=$(replace_version_separator 3 '-')
MM_PV=$(get_version_component_range '1-2')
MMD_PV=$(get_version_component_range '1-3')

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins/"
SRC_URI="http://launchpad.net/${MY_PN}/${MM_PV}/${MMD_PV}/+download/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="alsa compiz exif gio gmenu gnome kde mail musicplayer network-monitor powermanager terminal tomboy webkit wifi xfce xgamma xklavier"

RDEPEND="
	~x11-misc/cairo-dock-${PV}
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	kde? ( kde-base/kdelibs )
	terminal? ( x11-libs/vte )
	webkit? ( >=net-libs/webkit-gtk-1.0 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
"

DEPEND="${RDEPEND}
	dev-util/cmake
	sys-devel/gettext
	virtual/pkgconfig
"
src_prepare() {
	bzr_src_prepare
	distutils_src_prepare
	python_convert_shebangs -r 2 .
}

pkg_setup() {
	if use gio; then
		if ! use gmenu; then
			ewarn "gio requires gmenu, implicitly added"
		fi
	fi
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	cmake-utils_src_install
    distutils_src_install
}

pkg_postinst() {
	distutils_pkg_postinst
	ewarn "THIS IS A LIVE EBUILD, SO YOU KNOW THE RISKS !"
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	ewarn "Please report all bugs to #gentoo-desktop-effects"
	einfo "Thank you on behalf of the Gentoo Desktop-Effects team"
}
