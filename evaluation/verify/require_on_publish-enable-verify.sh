#!/usr/bin/env bash
# Execution VERIFY: PASS when field_rop_task on Article has third-party setting
# require_on_publish.require_on_publish === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_rop_task");
  $v = $fc ? $fc->getThirdPartySetting("require_on_publish", "require_on_publish", NULL) : NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " require_on_publish=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
