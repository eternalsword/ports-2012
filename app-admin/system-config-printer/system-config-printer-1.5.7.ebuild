# Distributed under the terms of the GNU General Public License v2

EAPI="5-progress"
GCONF_DEBUG="no"
PYTHON_ABI_TYPE="single"
PYTHON_RESTRICTED_ABIS="2.* *-jython *-pypy"
PYTHON_DEPEND="<<[xml]>>"
inherit gnome2 python versionator

MY_V="$(get_version_component_range 1-2)"

DESCRIPTION="GNOME frontend for a Red Hat's printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="http://cyberelk.net/tim/data/system-config-printer/${MY_V}/${P}.tar.xz"

LICENSE="GPL-2"
KEYWORDS="*"
SLOT="0"

IUSE="doc gnome-keyring policykit"

# Needs cups running, bug 284005
RESTRICT="test"

# Additional unhandled dependencies
# gnome-extra/gnome-packagekit[${PYTHON_USEDEP}] with pygobject:2 ?
# python samba client: smbc
# selinux: needed for troubleshooting
RDEPEND=">=dev-libs/glib-2:2
	virtual/libusb:1
	>=virtual/udev-172
	x11-libs/gtk+:3[introspection]
	x11-libs/libnotify[introspection]
	x11-libs/pango[introspection]
	gnome-keyring? ( gnome-base/libgnome-keyring[introspection] )
	policykit? ( >=sys-auth/polkit-0.104-r1 )
	!app-admin/system-config-printer-common
	!app-admin/system-config-printer-gnome
   $(python_abi_depend dev-libs/libxml2 dev-python/dbus-python dev-python/pycairo dev-python/pycups dev-python/pycurl dev-python/pygobject:3 net-print/cups[dbus])"

DEPEND="${RDEPEND}
	app-text/docbook-xml-dtd:4.1.2
	>=app-text/xmlto-0.0.22
	dev-util/desktop-file-utils
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( dev-python/epydoc )
"
APP_LINGUAS="ar as bg bn_IN bn br bs ca cs cy da de el en_GB es et fa fi fr gu
he hi hr hu hy id is it ja ka kn ko lo lv mai mk ml mr ms nb nl nn or pa pl
pt_BR pt ro ru si sk sl sr@latin sr sv ta te th tr uk vi zh_CN zh_TW"
for X in ${APP_LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

# Bug 471472
MAKEOPTS+=" -j1"

pkg_setup() {
	python_pkg_setup
}

src_configure() {
	local myconf

	# Disable installation of translations when LINGUAS not chosen
	if [[ -z "${LINGUAS}" ]]; then
		myconf="${myconf} --disable-nls"
	else
		myconf="${myconf} --enable-nls"
	fi

	gnome2_src_configure \
		--with-desktop-vendor=Gentoo \
		--with-udev-rules \
		${myconf}
}

src_compile() {
	gnome2_src_compile
	use doc && emake html
}

src_install() {
	gnome2_src_install
	use doc && dohtml -r html/
}
