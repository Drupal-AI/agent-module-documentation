#!/usr/bin/env bash
# Execution VERIFY: PASS when field_lh_task on Article has a non-empty Label Help third-party setting
# (third_party_settings.label_help.label_help_description). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_lh_task");
  $val = $fc ? $fc->getThirdPartySetting("label_help", "label_help_description") : NULL;
  $ok = (is_string($val) && strlen(trim($val)) > 0);
  print ($ok ? "PASS" : "FAIL") . " value=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
