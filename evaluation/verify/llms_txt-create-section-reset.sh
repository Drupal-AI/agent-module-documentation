#!/usr/bin/env bash
# Execution RESET: remove any llms_txt_section titled 'API Reference' so verify FAILS until the
# agent creates one. Leaves other sections untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("llms_txt_section")->loadByProperties(["title"=>"API Reference"]) as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: no llms_txt_section titled 'API Reference'"
