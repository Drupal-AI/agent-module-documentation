#!/usr/bin/env bash
# Execution RESET: delete site_audit.settings so no report subset is configured (verify FAILS
# on this empty state). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit.settings")->delete();' >/dev/null 2>&1
echo "reset: site_audit.settings removed (no report subset)"
