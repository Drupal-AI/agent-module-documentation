#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ift_disp's form-display widget is imagefield_tokens with
# preview_image_style 'thumbnail'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ift_disp") : NULL;
  $type = $c["type"] ?? "none";
  $style = $c["settings"]["preview_image_style"] ?? NULL;
  $ok = ($type === "imagefield_tokens" && $style === "thumbnail");
  print ($ok ? "PASS" : "FAIL") . " widget=" . $type . " preview_image_style=" . var_export($style, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
