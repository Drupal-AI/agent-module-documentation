#!/usr/bin/env bash
# Execution CLEANUP: restore empty version_mismatch. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("cms_content_sync.developer")->set("version_mismatch", [])->save();
' >/dev/null 2>&1
echo "cleanup: cms_content_sync.developer version_mismatch = {}"
