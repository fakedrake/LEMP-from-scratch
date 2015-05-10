#!/bin/bash
set -e

root_dir=$1
root_user=$2
root_pass=$3

${root_dir}/scripts/mysql_install_db --basedir=${root_dir} --user=${root_user}
${root_dir}/bin/mysqladmin -u ${root_user} password "${root_pass}"

# Mediawiki stuff
echo "Creating mediawiki database..."
${root_dir}/bin/mysqld
echo "create database wikidb; grant index, create, select, insert, update, delete, drop, alter, lock tables on wikidb.* to '${root_user}'@'localhost' identified by '${root_pass}'" | ${root_dir}/bin/mysql -u ${root_user} -p ${root_pass}
