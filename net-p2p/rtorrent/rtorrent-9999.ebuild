# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/rtorrent/rtorrent-0.9.3.ebuild,v 1.1 2013/03/22 08:29:46 patrick Exp $

EAPI=5

inherit eutils autotools

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="http://libtorrent.rakshasa.no/"
EGIT_REPO_URI="https://github.com/eternalsword/rtorrent.git"
inherit git-2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris"
IUSE="daemon tmux debug ipv6 test xmlrpc"

COMMON_DEPEND="=net-libs/libtorrent-9999
	>=dev-libs/libsigc++-2.2.2:2
	>=net-misc/curl-7.19.1
	sys-libs/ncurses
	xmlrpc? ( dev-libs/xmlrpc-c )"
RDEPEND="${COMMON_DEPEND}
	daemon? ( 
		tmux? ( app-misc/tmux )
		!tmux? ( app-misc/screen )
	)
	!daemon? (
		tmux? ( app-misc/tmux )
	)"
DEPEND="${COMMON_DEPEND}
	test? ( dev-util/cppunit )
	virtual/pkgconfig"

DOCS=( doc/rtorrent.rc )

src_prepare() {
	# upstream forgot to include
	cp ${FILESDIR}/rtorrent.1 ${S}/doc/ || die
	eautoreconf
}

src_configure() {
	# configure needs bash or script bombs out on some null shift, bug #291229
	CONFIG_SHELL=${BASH} econf \
		--disable-dependency-tracking \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with xmlrpc xmlrpc-c)
}

src_install() {
	default
	doman doc/rtorrent.1

	if use daemon; then
		if use tmux; then
			newinitd "${FILESDIR}/rtorrentd.tmux.init" rtorrentd
			cp "${FILESDIR}/rtorrent.tmux.conf" "${ED}/etc/rtorrent.tmux.conf" || die
		else
			newinitd "${FILESDIR}/rtorrentd.init" rtorrentd
		fi
		newconfd "${FILESDIR}/rtorrentd.conf" rtorrentd
	else
		if use tmux; then
			newinitd "${FILESDIR}/rtorrentd.tmux.init" rtorrentd
			cp "${FILESDIR}/rtorrent.tmux.conf" "${ED}/etc/rtorrent.tmux.conf" || die
		fi
	fi
}
