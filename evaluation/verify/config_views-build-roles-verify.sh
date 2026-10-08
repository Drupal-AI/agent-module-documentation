#!/usr/bin/env bash
# VERIFY: PASS when View cv_roles exists with base_table config_user_role.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("cv_roles");
  $bt = $v ? $v->get("base_table") : "none";
  $ok = ($bt === "config_user_role");
  print ($ok ? "PASS" : "FAIL") . " view=" . ($v ? "yes" : "no") . " base_table=" . $bt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
