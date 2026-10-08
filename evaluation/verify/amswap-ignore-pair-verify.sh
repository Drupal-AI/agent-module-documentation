#!/usr/bin/env bash
# Execution VERIFY: PASS when amswap.amswapconfig has a pair role=amswap_task2, menu=footer,
# and ignored_roles containing 'administrator'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $pairs = \Drupal::config("amswap.amswapconfig")->get("role_menu_pairs") ?: [];
  $ok = FALSE;
  foreach ($pairs as $p) {
    if (($p["role"] ?? "")==="amswap_task2" && ($p["menu"] ?? "")==="footer"
        && in_array("administrator", $p["ignored_roles"] ?? [], TRUE)) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " pairs=" . json_encode($pairs) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
