#!/usr/bin/env bash
# Execution VERIFY (insert_responsive_image): PASS when field_insert_ritask's image_image component in
# core.entity_form_display.node.article.default has third_party_settings.insert.styles containing
# responsive_image__insert_ri_demo. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_insert_ritask") : NULL;
  $styles = $c["third_party_settings"]["insert"]["styles"] ?? [];
  $styles = is_array($styles) ? array_filter($styles) : [];
  $ok = (($c["type"] ?? "") === "image_image" && array_key_exists("responsive_image__insert_ri_demo", $styles));
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " styles=" . implode(",", array_keys($styles)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
