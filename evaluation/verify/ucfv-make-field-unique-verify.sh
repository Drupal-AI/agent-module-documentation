#!/usr/bin/env bash
# Execution VERIFY: PASS when field.field.node.article.field_ucfv_code third_party
# unique_content_field_validation.unique is TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_ucfv_code");
  $u = $fc ? $fc->getThirdPartySetting("unique_content_field_validation", "unique", FALSE) : NULL;
  $ok = ($u === TRUE || $u === 1 || $u === "1");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($fc ? "yes" : "no") . " unique=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
