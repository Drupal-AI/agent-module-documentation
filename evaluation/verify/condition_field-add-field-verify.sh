#!/usr/bin/env bash
# Execution VERIFY: PASS when node.article has field_cf_task of type condition_field whose
# enabled_plugins enables both request_path and user_role. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_cf_task");
  $fc = FieldConfig::loadByName("node", "article", "field_cf_task");
  $type = $fs ? $fs->getType() : "none";
  $ep = $fc ? ($fc->getSetting("enabled_plugins") ?: []) : [];
  $has_rp = !empty($ep["request_path"]);
  $has_ur = !empty($ep["user_role"]);
  $ok = $fs && $fc && $type === "condition_field" && $has_rp && $has_ur;
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " request_path=" . var_export($has_rp, TRUE) . " user_role=" . var_export($has_ur, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
