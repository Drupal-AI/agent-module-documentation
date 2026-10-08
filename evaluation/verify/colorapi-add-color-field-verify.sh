#!/usr/bin/env bash
# Execution VERIFY: PASS when a field storage node.field_cai_color of type colorapi_color_field
# exists AND is attached to the Article bundle. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_cai_color");
  $fc = FieldConfig::loadByName("node", "article", "field_cai_color");
  $type = $fs ? $fs->getType() : NULL;
  $ok = ($fs && $fc && $type === "colorapi_color_field");
  print ($ok ? "PASS" : "FAIL") . " storage=" . ($fs ? "yes" : "no") . " type=" . var_export($type, TRUE) . " onArticle=" . ($fc ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
