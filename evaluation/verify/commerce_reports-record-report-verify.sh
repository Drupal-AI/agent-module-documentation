#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("commerce_order_report");
  $es = $s->loadByProperties(["mail" => "buyer5150@example.test"]);
  $ok = FALSE;
  foreach ($es as $e) {
    $amt = $e->get("amount")->first();
    if ($e->bundle() === "order_report"
        && (int) $e->get("order_id")->target_id === 5150
        && $amt && (string) $amt->currency_code === "USD" && (float) $amt->number == 75.0) { $ok = TRUE; break; }
  }
  print $ok ? "PASS" : "FAIL";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
