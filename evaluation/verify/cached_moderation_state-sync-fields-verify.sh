#!/usr/bin/env bash
# PASS when the cached_moderation_state field instance exists again on cachedmod_sync.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $ok=(bool)FieldConfig::loadByName("node","cachedmod_sync","cached_moderation_state");
  print ($ok?"PASS":"FAIL")." field_instance=".var_export($ok,TRUE)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
