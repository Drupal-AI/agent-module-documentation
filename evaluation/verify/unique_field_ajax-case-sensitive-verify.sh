#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ufa_case on Article is BOTH unique AND case_sensitive via
# unique_field_ajax third-party settings (both truthy). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_ufa_case");
  $u = $fc ? $fc->getThirdPartySetting("unique_field_ajax", "unique") : NULL;
  $cs = $fc ? $fc->getThirdPartySetting("unique_field_ajax", "case_sensitive") : NULL;
  $ok = (!empty($u) && !empty($cs));
  print ($ok ? "PASS" : "FAIL") . " unique=" . var_export($u, TRUE) . " case_sensitive=" . var_export($cs, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
