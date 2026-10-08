#!/usr/bin/env bash
# Execution VERIFY: PASS when the default commerce_product display's 'variations' component has
# third_party_settings.commerce_ajax_atc.enable_ajax === TRUE. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $repo = \Drupal::service("entity_display.repository");
  $d = $repo->getViewDisplay("commerce_product", "default", "default");
  $c = $d->getComponent("variations");
  $v = $c["third_party_settings"]["commerce_ajax_atc"]["enable_ajax"] ?? NULL;
  $ok = ($v === TRUE);
  print ($ok ? "PASS" : "FAIL") . " enable_ajax=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
