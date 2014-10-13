# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"
MATE_LA_PUNT="yes"

inherit autotools eutils mate

DESCRIPTION="Disk Utility for MATE using udisks"
HOMEPAGE="https://github.com/NiceandGently/mate-disk-utility"
SRC_URI="https://github.com/NiceandGently/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="fat gnome-keyring caja remote-access"
KEYWORDS="alpha amd64 arm ia64 ppc ppc64 sh sparc x86"

CDEPEND="
	>=dev-libs/glib-2.22:2
	>=dev-libs/dbus-glib-0.74
	>=dev-libs/libunique-1.0:1
	>=x11-libs/gtk+-2.20:2
	>=x11-libs/libnotify-0.6.1
	caja? ( || ( >=mate-base/mate-file-manager-1.6.0
			mate-base/caja ) )"

RDEPEND="${CDEPEND}
	=sys-fs/udisks-1.0*:0[remote-access?]
	x11-misc/xdg-utils
	fat? ( sys-fs/dosfstools )"
DEPEND="${CDEPEND}
	sys-devel/gettext
	mate-base/mate-common
	app-text/docbook-xml-dtd:4.1.2
	app-text/rarian
	app-text/mate-doc-utils
	virtual/pkgconfig
	>=dev-util/intltool-0.35"

src_configure() {
	DOCS="AUTHORS NEWS README TODO"

	mate_src_configure \
		--disable-static \
		--disable-mate-keyring \
		--enable-gtk-doc \
		$(use_enable caja) \
		$(use_enable remote-access)
}

