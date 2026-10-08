#!/usr/bin/env bash
# Execution VERIFY: PASS when field_insert_pic keeps the image_image widget AND its
# third_party_settings.insert.styles is non-empty and includes the "image" (Original image) style.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_insert_pic") : NULL;
  $styles = $c["third_party_settings"]["insert"]["styles"] ?? [];
  $styles = is_array($styles) ? array_filter($styles) : [];
  $ok = (($c["type"] ?? "") === "image_image" && count($styles) > 0 && array_key_exists("image", $styles));
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " styles=" . implode(",", array_keys($styles)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
