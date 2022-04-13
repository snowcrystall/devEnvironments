#!/bin/sh


cd /home/git/
mkdir -p log/ tmp/sockets public/uploads/ repositories/
mv /home/git/gitaly/_build/bin /home/git/gitaly/bin 
mv /home/git/gitlab/config/gitalyconfig.toml /home/git/gitaly/config.toml
chmod -R +x /home/git/gitaly/ruby/git-hooks/*
chmod -R +x /home/git/gitaly/ruby/bin/*

service postgresql start
sudo -u postgres psql -d template1 -c "CREATE USER git CREATEDB PASSWORD '123456';"
sudo -u postgres psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS pg_trgm;"
sudo -u postgres psql -d template1 -c "CREATE EXTENSION IF NOT EXISTS btree_gist;"
sudo -u postgres psql -d template1 -c "CREATE DATABASE gitlabhq_production OWNER git;"

/home/git/gitlab/bin/daemon_with_pidfile /home/git/tmp/pids/gitaly.pid /home/git/gitaly/bin/gitaly /home/git/gitaly/config.toml >> /home/git/log/gitaly.log 2>&1 &

cd /home/git/gitlab
bundle exec rake gitlab:setup RAILS_ENV=production force=yes 
service postgresql stop





