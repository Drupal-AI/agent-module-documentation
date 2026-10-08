#!/usr/bin/env bash
# VERIFY: PASS when View cv_styles exists with base_table config_image_style.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("cv_styles");
  $bt = $v ? $v->get("base_table") : "none";
  $ok = ($bt === "config_image_style");
  print ($ok ? "PASS" : "FAIL") . " view=" . ($v ? "yes" : "no") . " base_table=" . $bt . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
