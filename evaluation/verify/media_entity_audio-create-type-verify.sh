#!/usr/bin/env bash
# Execution VERIFY: PASS when a media type mea_task exists whose media source is 'audio_stream'
# and whose configured source field is a link field. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("mea_task");
  $src = $t ? $t->getSource()->getPluginId() : "none";
  $ftype = "none";
  if ($t) {
    $def = $t->getSource()->getSourceFieldDefinition($t);
    $ftype = $def ? $def->getType() : "unset";
  }
  $ok = ($src === "audio_stream" && $ftype === "link");
  print ($ok ? "PASS" : "FAIL") . " source=" . $src . " source_field_type=" . $ftype . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
