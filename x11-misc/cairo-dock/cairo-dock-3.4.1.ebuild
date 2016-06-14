# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils eutils versionator

MY_PN="${PN}-core"
MY_PV=$(replace_version_separator 3 '-')
MM_PV=$(get_version_component_range '1-2')
MMD_PV=$(get_version_component_range '1-3')

DESCRIPTION="Cairo-dock is a fast, responsive, Mac OS X-like dock."
HOMEPAGE="https://launchpad.net/cairo-dock-core/"
SRC_URI="http://launchpad.net/${MY_PN}/${MM_PV}/${MMD_PV}/+download/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xcomposite"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/librsvg
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/gtkglext
	x11-libs/libXrender
	xcomposite? (
		x11-libs/libXcomposite
		x11-libs/libXinerama
		x11-libs/libXtst
	)
"
DEPEND="${RDEPEND}
	dev-util/cmake
	virtual/pkgconfig
	sys-devel/gettext
"

src_prepare() {
	bzr_src_prepare
}

src_compile() {
        cmake-utils_src_compile
}

src_install() {
        cmake-utils_src_install
}

pkg_postinst() {
	ewarn "THIS IS A LIVE EBUILD, SO YOU KNOW THE RISKS !"
	ewarn "DO NOT report bugs to Gentoo's bugzilla"
	ewarn "Please report all bugs to #gentoo-desktop-effects"
	einfo "Thank you on behalf of the Gentoo Desktop-Effects team"
}
