#!/usr/bin/env bash
# Introspection CLEANUP: delete the 'LLMS Eval Docs' section(s). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("llms_txt_section")->loadByProperties(["title"=>"LLMS Eval Docs"]) as $s) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: 'LLMS Eval Docs' section removed"
