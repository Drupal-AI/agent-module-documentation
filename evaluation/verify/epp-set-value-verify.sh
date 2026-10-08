#!/usr/bin/env bash
# Execution VERIFY: PASS when field_epp_task on Article carries a non-empty epp.value third-party
# setting. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_epp_task");
  $v = $fc ? $fc->getThirdPartySetting("epp","value") : NULL;
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
