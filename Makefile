#!/usr/bin/make -f
PACKAGE?=connect-proxy
#URL=http://www.meadowy.org/~gotoh/projects/connect/browser/trunk/connect.c?format=raw
URL=http://www.meadowy.org/~gotoh/ssh/connect.c
INSTALL_DIR?=${DESTDIR}/usr
OBJS?=connect.o

all default: ${PACKAGE} 

install: ${PACKAGE}
	-mkdir -p ${INSTALL_DIR}/bin/
	install ${PACKAGE} ${INSTALL_DIR}/bin/
#	ln -fs ${PACKAGE} ${INSTALL_DIR}/bin/connect

${PACKAGE}: ${OBJS}
	    ${CC} -o $@ $^ ${LDFLAGS} 
clean: 
	${RM} ${PACKAGE} ${PACKAGE}.o *~ ${OBJS} || echo "# $@: $^"

# connect.c:
#	wget -O $@ "${URL}"

update:
	wget -O connect.c "${URL}"

LICENCE: /usr/share/apps/LICENSES/GPL_V2
	ln -fs $^ $@

#eof "$Id: connect-proxy/Makefile --  rzr@users.sf.net $"
# Makefile for proxy-connect
#
# Copyright (C) 2013 Conrad Meyer
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

WARNFLAGS = -Wall -Wextra
OPTFLAGS = -O2 -g -pipe -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -mtune=generic

connect: connect.c
	gcc -o $@  $(OPTFLAGS) $(WARNFLAGS) $^
