#!/usr/bin/env bash
# CLEANUP: restore the shipped default items-per-page (50). Exit 0.
set -uo pipefail
cd /var/www/html
drush config:set auditfiles.settings auditfiles_report_options_items_per_page 50 -y >/dev/null 2>&1
echo "cleanup: auditfiles_report_options_items_per_page restored to 50"
