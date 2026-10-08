#!/usr/bin/env bash
# Execution VERIFY (popup_field_group, layman): PASS when the Article default VIEW display has a
# field group whose format_type === "popup". Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $hit = NULL;
  foreach ($vd->getThirdPartySettings("field_group") as $name => $g) {
    if (($g["format_type"] ?? NULL) === "popup") { $hit = $name; break; }
  }
  print ($hit ? "PASS group=" . $hit : "FAIL no popup group") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
