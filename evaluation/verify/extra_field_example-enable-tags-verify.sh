#!/usr/bin/env bash
# Execution VERIFY: PASS when extra_field_example is installed AND its "multilingual_field"
# pseudo-field (extra_field_multilingual_field, the 'Concatenated tags' plugin) is placed in
# the content region of core.entity_view_display.node.article.default. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $installed = \Drupal::moduleHandler()->moduleExists("extra_field_example");
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("extra_field_multilingual_field") : NULL;
  $placed = is_array($c);
  $ok = $installed && $placed;
  print ($ok ? "PASS" : "FAIL") . " module=" . ($installed ? "installed" : "no")
    . " placed=" . ($placed ? "yes" : "no")
    . " weight=" . var_export($c["weight"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
