#!/usr/bin/env bash
# Execution VERIFY: PASS when field_epp_task on Article has epp.on_update === TRUE (and still has a
# value). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node","article","field_epp_task");
  $ou = $fc ? $fc->getThirdPartySetting("epp","on_update") : NULL;
  $v  = $fc ? $fc->getThirdPartySetting("epp","value") : NULL;
  $ok = ($ou === TRUE) && !empty($v);
  print ($ok ? "PASS" : "FAIL") . " on_update=" . var_export($ou, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
