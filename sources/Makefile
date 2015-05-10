root-dir ?= $(CURDIR)/../root

# NGINX
nginx-url = http://nginx.org/download/nginx-1.9.0.tar.gz
nginx-conf = ./configure --prefix=$(root-dir) --with-http_stub_status_module --with-http_ssl_module

# MariaDB
mariadb-url = http://ftp.cc.uoc.gr/mirrors/mariadb/mariadb-10.0.19/source/mariadb-10.0.19.tar.gz
mariadb-conf = cmake . -DCMAKE_INSTALL_PREFIX:PATH=$(root-dir) -DBUILD_CONFIG=mysql_release

# MySQL
mysql-url = http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-5.6.15.tar.gz
mysql-conf = cmake . -DCMAKE_INSTALL_PREFIX:PATH=$(root-dir) -DCMAKE_BUILD_TYPE=Release
mysql-post = $(root-dir)/bin/setup-mysql.sh

# PHP
php-url = http://ar2.php.net/get/php-5.6.8.tar.gz/from/this/mirror

# fpm for nginx and the rest is from here: https://www.mediawiki.org/wiki/PHP_configuration
php-conf = ./configure \
	--with-mysql \
	--with-zlib \
	--with-ldap \
	--with-gd \
	--with-jpeg-dir \
	--with-iconv-dir \
	--enable-mbstring  \
	--enable-fpm \
	--prefix=$(root-dir)

# MediaWiki
mediawiki-url = http://releases.wikimedia.org/mediawiki/1.24/mediawiki-1.24.2.tar.gz

%.tar.gz:
	wget $($*-url) -O $@

%_src: %.tar.gz
	tar xvzf $<
	mv $*-* $@

%_src/Makefile: %_src
	cd $*_src && \
	$($*-conf)

.PHONY:
%-build: %_src/Makefile
	$(MAKE) -j8 -C $*_src install
	$(MAKE) $*-post

.PHONY:
%-post:
	$($*-post)

%-clean:
	rm -rf $**
