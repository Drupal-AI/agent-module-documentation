#!/usr/bin/env bash
# Execution VERIFY: PASS when commerce_ajax_atc.settings has pop_up_type=modal_dialog AND
# include_cart_button truthy. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("commerce_ajax_atc.settings");
  $ok = ($c->get("pop_up_type") === "modal_dialog") && !empty($c->get("include_cart_button"));
  print ($ok ? "PASS" : "FAIL") . " pop_up_type=" . var_export($c->get("pop_up_type"), TRUE) . " cart_button=" . var_export((bool) $c->get("include_cart_button"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
