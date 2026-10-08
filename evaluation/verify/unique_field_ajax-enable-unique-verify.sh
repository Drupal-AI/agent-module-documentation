#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ufa_task on Article carries a truthy
# third_party_settings.unique_field_ajax.unique. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_ufa_task");
  $u = $fc ? $fc->getThirdPartySetting("unique_field_ajax", "unique") : NULL;
  $ok = !empty($u);
  print ($ok ? "PASS" : "FAIL") . " unique=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
