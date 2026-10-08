#!/usr/bin/env bash
# Execution VERIFY: PASS when a field named field_ccof_note exists on commerce_order 'default'
# AND it is an enabled component on the Checkout form display
# (core.entity_form_display.commerce_order.default.checkout). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $field = FieldConfig::loadByName("commerce_order", "default", "field_ccof_note");
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("commerce_order.default.checkout");
  $comp = $fd ? $fd->getComponent("field_ccof_note") : NULL;
  $ok = ($field !== NULL) && is_array($comp);
  print ($ok ? "PASS" : "FAIL") . " field=" . ($field ? "yes" : "no") . " checkout_component=" . (is_array($comp) ? "yes" : "no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
