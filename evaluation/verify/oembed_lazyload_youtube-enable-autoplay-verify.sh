#!/usr/bin/env bash
# Execution VERIFY: PASS when field_oly_task's lazyload_oembed formatter has
# third_party_settings.oembed_lazyload_youtube.autoplay === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_oly_task") : NULL;
  $ap = $c["third_party_settings"]["oembed_lazyload_youtube"]["autoplay"] ?? NULL;
  $ok = ($ap === TRUE);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . ($c["type"] ?? "none") . " autoplay=" . var_export($ap, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
