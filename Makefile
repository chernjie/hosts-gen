# hosts-gen
# See LICENSE file for copyright and license details.

include config.mk

all:

dist:
	@echo creating dist tarball
	@mkdir -p hosts-gen-${VERSION}
	@cp -R LICENSE Makefile hosts-gen.1 config.mk etc examples bin hosts-gen-${VERSION}
	@tar -cf hosts-gen-${VERSION}.tar hosts-gen-${VERSION}
	@gzip hosts-gen-${VERSION}.tar
	@rm -rf hosts-gen-${VERSION}

install: all
	@echo installing script to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f bin/hosts-gen ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/hosts-gen
	@echo installing ${DESTDIR}/etc/hosts.d
	@mkdir -p ${DESTDIR}/etc/hosts.d
	@cp -R etc/hosts.d/* ${DESTDIR}/etc/hosts.d
	@echo installing manual page to ${DESTDIR}${MANPREFIX}/man1
	@mkdir -p ${DESTDIR}${MANPREFIX}/man1
	@sed "s/VERSION/${VERSION}/g" < hosts-gen.1 > ${DESTDIR}${MANPREFIX}/man1/hosts-gen.1
	@chmod 644 ${DESTDIR}${MANPREFIX}/man1/hosts-gen.1

uninstall:
	@echo removing script from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/hosts-gen
	@echo removing manual page from ${DESTDIR}${MANPREFIX}/man1
	@rm -f ${DESTDIR}${MANPREFIX}/man1/hosts-gen.1
	@echo you need to manually remove the ${DESTDIR}/etc/hosts.d directory

.PHONY: all dist install uninstall
