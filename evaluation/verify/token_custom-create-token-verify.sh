#!/usr/bin/env bash
# Execution VERIFY: PASS when custom token tc_task (type custom) exists AND [custom:tc_task]
# replaces to text containing 'Support ticket resolved'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\token_custom\Entity\TokenCustom;
  $e = TokenCustom::load("tc_task");
  $rep = \Drupal::token()->replace("[custom:tc_task]");
  $ok = $e && $e->bundle() === "custom" && strpos($rep, "Support ticket resolved") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export((bool)$e, TRUE) . " replaced=" . trim(strip_tags($rep)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
