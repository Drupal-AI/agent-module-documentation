#!/usr/bin/env bash
# Execution VERIFY: PASS when field_oly_rel's lazyload_oembed formatter has
# third_party_settings.oembed_lazyload_youtube.rel === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_oly_rel") : NULL;
  $rel = $c["third_party_settings"]["oembed_lazyload_youtube"]["rel"] ?? NULL;
  $ok = ($rel === TRUE);
  print ($ok ? "PASS" : "FAIL") . " formatter=" . ($c["type"] ?? "none") . " rel=" . var_export($rel, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
