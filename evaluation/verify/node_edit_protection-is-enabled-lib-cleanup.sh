#!/usr/bin/env bash
# Introspection CLEANUP: baseline is node_edit_protection enabled; leave it enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install node_edit_protection -y >/dev/null 2>&1 || true
echo "cleanup: node_edit_protection left enabled (baseline)"
