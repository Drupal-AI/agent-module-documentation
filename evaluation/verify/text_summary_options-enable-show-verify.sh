#!/usr/bin/env bash
# Execution VERIFY: PASS when field_tso_show's FieldConfig carries
# third_party_settings.text_summary_options.show_summary === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fc = \Drupal\field\Entity\FieldConfig::loadByName("node","article","field_tso_show");
  $v = $fc ? $fc->getThirdPartySetting("text_summary_options","show_summary") : NULL;
  $ok = ((bool)$v === TRUE);
  print ($ok?"PASS":"FAIL")." show_summary=".var_export($v,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
