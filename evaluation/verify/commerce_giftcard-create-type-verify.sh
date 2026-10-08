#!/usr/bin/env bash
# Execution VERIFY: PASS when gift-card type cg_task exists with generate.length == 12. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("commerce_giftcard.giftcard_type.cg_task");
  $len = $c->get("generate.length");
  $exists = $c->get("id") !== NULL;
  $ok = $exists && ((int) $len === 12);
  print ($ok ? "PASS" : "FAIL") . " id=" . var_export($c->get("id"), TRUE) . " length=" . var_export($len, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
