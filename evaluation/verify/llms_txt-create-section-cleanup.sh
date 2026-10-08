#!/usr/bin/env bash
# Execution CLEANUP: delete any 'API Reference' section(s). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("llms_txt_section")->loadByProperties(["title"=>"API Reference"]) as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'API Reference' section removed"
