#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tso_ph's FieldConfig carries a non-empty
# third_party_settings.text_summary_options.summary_placeholder. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tso_ph");
  $v = $fc ? $fc->getThirdPartySetting("text_summary_options","summary_placeholder") : NULL;
  $ok = (is_string($v) && trim($v) !== "");
  print ($ok?"PASS":"FAIL")." placeholder=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
