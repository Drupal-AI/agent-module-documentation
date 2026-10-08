#!/usr/bin/env bash
# Execution VERIFY: PASS when the field_slf_widget component on core.entity_form_display.node.article.default
# uses the social_links widget with settings.disable_weight === TRUE. Read-only. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_slf_widget") : NULL;
  $dw = $c["settings"]["disable_weight"] ?? NULL;
  $ok = (($c["type"] ?? "") === "social_links") && ($dw === TRUE);
  print ($ok ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . " disable_weight=" . var_export($dw, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
