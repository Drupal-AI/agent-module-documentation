#!/usr/bin/env bash
# Execution VERIFY: PASS when a field_token_value field field_ftv_task exists on node.article and
# its settings.field_value contains a token. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("node", "article", "field_ftv_task");
  $type = $fc ? $fc->getType() : "none";
  $val = $fc ? (string) ($fc->getSetting("field_value") ?? "") : "";
  $ok = ($fc && $type === "field_token_value" && str_contains($val, "["));
  print ($ok ? "PASS" : "FAIL") . " type=$type field_value=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
