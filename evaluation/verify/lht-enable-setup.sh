#!/usr/bin/env bash
# Introspection SETUP: install label_help_test so the fixture content type/fields exist to inspect.
# Baseline is uninstalled; the matching cleanup uninstalls again. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install label_help_test -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: label_help_test installed"
