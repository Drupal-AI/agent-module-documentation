#!/usr/bin/env bash
# Execution VERIFY (sdc_display, layman): PASS when the Article default view display has a field
# group whose format_type === "sdc_display". Read-only. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $hit = NULL;
  foreach ($vd->getThirdPartySettings("field_group") as $name => $g) {
    if (($g["format_type"] ?? NULL) === "sdc_display") { $hit = $name; break; }
  }
  print ($hit ? "PASS group=" . $hit : "FAIL no sdc_display group") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
