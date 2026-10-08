#!/usr/bin/env bash
# Execution VERIFY: PASS when Article has a field field_dte_time whose storage type is the
# datetime_extras 'time_only_field' field type. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_dte_time");
  $fc = FieldConfig::loadByName("node", "article", "field_dte_time");
  $type = $fs ? $fs->getType() : NULL;
  $ok = ($fs && $fc && $type === "time_only_field");
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs ? "1" : "0") . " onArticle=" . ($fc ? "1" : "0") . " type=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
