#!/usr/bin/env bash
# Execution VERIFY: PASS when the cachedmod_page bundle has a cached_moderation_state field
# instance (i.e. moderation-state caching is enabled for it). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $ok = (bool) FieldConfig::loadByName("node", "cachedmod_page", "cached_moderation_state");
  print ($ok ? "PASS" : "FAIL") . " field_instance=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
