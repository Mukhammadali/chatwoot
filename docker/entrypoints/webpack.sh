#!/bin/sh
set -e

rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

yarn install --network-timeout 100000 --check-files

echo "Waiting for yarn and bundle integrity to match lockfiles...."
YARN="yarn check --integrity"
BUNDLE="bundle check"

until $YARN && $BUNDLE
do
  sleep 2;
done

echo "Ready to run webpack development server."

exec "$@"
