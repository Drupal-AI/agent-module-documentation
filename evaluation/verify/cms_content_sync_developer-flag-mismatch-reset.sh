#!/usr/bin/env bash
# Execution RESET: clear version_mismatch so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cms_content_sync.developer")->set("version_mismatch", [])->save();
' >/dev/null 2>&1
echo "reset: cms_content_sync.developer version_mismatch = {}"
