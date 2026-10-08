#!/usr/bin/env bash
# Execution VERIFY for "make Permissions by Term whitelist-only, require every term, and manage
# only the pbt_lock_vocab vocabulary".
# PASS when permissions_by_term.settings has permission_mode TRUE, require_all_terms_granted
# TRUE and target_bundles containing exactly pbt_lock_vocab.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("permissions_by_term.settings");
  $truthy = fn($v) => ($v === TRUE || $v === 1 || $v === "1");
  $bundles = array_values(array_filter((array) $c->get("target_bundles")));
  $ok = $truthy($c->get("permission_mode"))
    && $truthy($c->get("require_all_terms_granted"))
    && $bundles === ["pbt_lock_vocab"];
  print ($ok ? "PASS" : "FAIL")
    . " permission_mode=" . var_export($c->get("permission_mode"), TRUE)
    . " require_all_terms_granted=" . var_export($c->get("require_all_terms_granted"), TRUE)
    . " target_bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
