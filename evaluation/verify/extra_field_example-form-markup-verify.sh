#!/usr/bin/env bash
# Execution VERIFY: PASS when extra_field_example_markup is an enabled component of
# core.entity_form_display.node.article.default with weight 25. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $installed = \Drupal::moduleHandler()->moduleExists("extra_field_example");
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("extra_field_example_markup") : NULL;
  $weight = $c["weight"] ?? NULL;
  $ok = $installed && is_array($c) && ((int) $weight === 25);
  print ($ok ? "PASS" : "FAIL") . " module=" . ($installed ? "installed" : "no")
    . " placed=" . (is_array($c) ? "yes" : "no")
    . " weight=" . var_export($weight, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
