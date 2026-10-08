#!/usr/bin/env bash
# Execution VERIFY: PASS when a Duration field field_df_task exists on Article (storage type
# 'duration', instance on node.article) with granularity 'h:i:s'. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_df_task");
  $fc = FieldConfig::loadByName("node", "article", "field_df_task");
  $type = $fs ? $fs->getType() : "";
  $gran = $fc ? $fc->getSetting("granularity") : "";
  $ok = ($fs && $type === "duration" && $fc && $gran === "h:i:s");
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs ? "1" : "0") . " type=" . var_export($type, TRUE) . " instance=" . ($fc ? "1" : "0") . " granularity=" . var_export($gran, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
