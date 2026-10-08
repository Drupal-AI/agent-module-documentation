#!/usr/bin/env bash
# Execution VERIFY: PASS when twig_tools is installed AND its filters are registered in the live
# Twig environment (checks hex_to_css_rgb + scrub_class_array). Read-only. Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $on = \Drupal::moduleHandler()->moduleExists("twig_tools");
  $twig = \Drupal::service("twig");
  $has = $on && $twig->getFilter("hex_to_css_rgb") && $twig->getFilter("scrub_class_array");
  print ($has ? "PASS" : "FAIL") . " installed=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
