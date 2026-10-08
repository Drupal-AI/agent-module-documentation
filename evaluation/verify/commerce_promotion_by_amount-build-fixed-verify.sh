#!/usr/bin/env bash
# Execution VERIFY: PASS when a promotion named 'cpba_fixed' exists whose offer is
# order_item_fixed_amount_off_by_amount with type=most_expensive. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ps = \Drupal::entityTypeManager()->getStorage("commerce_promotion")->loadByProperties(["name"=>"cpba_fixed"]);
  $ok = FALSE; $pid = "none"; $type = "none";
  foreach ($ps as $p) {
    $o = $p->get("offer")->first() ? $p->get("offer")->first()->getValue() : [];
    $pid = $o["target_plugin_id"] ?? "none";
    $type = $o["target_plugin_configuration"]["type"] ?? "none";
    if ($pid === "order_item_fixed_amount_off_by_amount" && $type === "most_expensive") { $ok = TRUE; break; }
  }
  print ($ok ? "PASS" : "FAIL") . " plugin=$pid type=$type\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
