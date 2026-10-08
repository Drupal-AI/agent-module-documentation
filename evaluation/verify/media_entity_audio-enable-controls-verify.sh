#!/usr/bin/env bash
# Execution VERIFY: PASS when the mea_show media type's source field display uses the
# audio_stream_html5 formatter with controls === TRUE. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\media\Entity\MediaType;
  $t = MediaType::load("mea_show");
  $sf = $t ? ($t->get("source_configuration")["source_field"] ?? NULL) : NULL;
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mea_show.default");
  $c = ($vd && $sf) ? $vd->getComponent($sf) : NULL;
  $type = $c["type"] ?? "none";
  $controls = $c["settings"]["controls"] ?? NULL;
  $ok = ($type === "audio_stream_html5" && $controls === TRUE);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $type . " controls=" . var_export($controls, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
