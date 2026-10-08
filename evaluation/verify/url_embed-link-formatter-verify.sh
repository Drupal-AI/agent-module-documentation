#!/usr/bin/env bash
# Execution VERIFY for "switch field_url_embed_task's default display to the url_embed
# (Embedded URL) formatter with responsive wrapping enabled". PASS when the component's type
# is 'url_embed' and settings.enable_responsive === TRUE. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_url_embed_task") : NULL;
  $type = $c["type"] ?? "none";
  $responsive = $c["settings"]["enable_responsive"] ?? NULL;
  $ok = ($type === "url_embed") && ($responsive === TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " enable_responsive=" . var_export($responsive, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
