# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=2

inherit gtk-sharp-module

SLOT="2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""
SRC_URI="https://github.com/mono/gtk-sharp/archive/${PV}.tar.gz"

RESTRICT="test"
