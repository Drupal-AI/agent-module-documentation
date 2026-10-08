#!/usr/bin/env bash
# Introspection SETUP: set auditfiles items-per-page to a known value (17) so an agent can read
# it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set auditfiles.settings auditfiles_report_options_items_per_page 17 -y >/dev/null 2>&1
echo "setup: auditfiles_report_options_items_per_page=17"
