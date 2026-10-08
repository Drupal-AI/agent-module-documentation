#!/usr/bin/env bash
# Execution VERIFY: PASS when custom token TYPE tc_dept exists AND a token tc_manager of that
# type exists AND [tc_dept:tc_manager] replaces to text containing 'Jane Doe'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\token_custom\Entity\TokenCustom;
  use Drupal\token_custom\Entity\TokenCustomType;
  $t = TokenCustomType::load("tc_dept");
  $e = TokenCustom::load("tc_manager");
  $rep = \Drupal::token()->replace("[tc_dept:tc_manager]");
  $ok = $t && $e && $e->bundle() === "tc_dept" && strpos($rep, "Jane Doe") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " type=" . var_export((bool)$t, TRUE) . " token=" . var_export((bool)$e, TRUE) . " replaced=" . trim(strip_tags($rep)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
