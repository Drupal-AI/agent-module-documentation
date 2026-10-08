#!/usr/bin/env bash
# Execution VERIFY: PASS when a field storage node.field_veh_video of type video_embed_field is
# attached to the article bundle AND its allowed_providers setting is exactly ['html_5'].
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  $fs = FieldStorageConfig::loadByName("node", "field_veh_video");
  $fc = FieldConfig::loadByName("node", "article", "field_veh_video");
  $ap = $fc ? array_values((array) $fc->getSetting("allowed_providers")) : [];
  $ok = ($fs && $fs->getType() === "video_embed_field" && $fc && $ap === ["html_5"]);
  print ($ok ? "PASS" : "FAIL") . " type=" . ($fs ? $fs->getType() : "none") . " allowed_providers=" . json_encode($ap) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
