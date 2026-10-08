#!/usr/bin/env bash
# Introspection SETUP: create role migsui_operator and grant it 'access migrate source ui' so
# an agent can inspect which role may run the migrate source UI. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush role:create migsui_operator "Migsui Operator" >/dev/null 2>&1 || true
drush role:perm:add migsui_operator 'access migrate source ui' >/dev/null 2>&1 || true
echo "setup: role migsui_operator has 'access migrate source ui'"
