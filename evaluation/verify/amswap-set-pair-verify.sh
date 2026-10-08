#!/usr/bin/env bash
# Execution VERIFY: PASS when amswap.amswapconfig role_menu_pairs contains a pair with
# role=amswap_task and menu=tools. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $pairs = \Drupal::config("amswap.amswapconfig")->get("role_menu_pairs") ?: [];
  $ok = FALSE;
  foreach ($pairs as $p) { if (($p["role"] ?? "")==="amswap_task" && ($p["menu"] ?? "")==="tools") { $ok = TRUE; } }
  print ($ok ? "PASS" : "FAIL") . " pairs=" . json_encode($pairs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
