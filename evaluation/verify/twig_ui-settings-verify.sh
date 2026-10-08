#!/usr/bin/env bash
# Execution VERIFY: PASS when twig_ui.settings restricts allowed themes to a selected list that
# contains olivero (allowed_themes=selected AND olivero in allowed_theme_list). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("twig_ui.settings");
  $mode = $c->get("allowed_themes");
  $list = $c->get("allowed_theme_list") ?: [];
  $list = array_values(array_filter($list));
  $ok = ($mode === "selected" && in_array("olivero", $list, TRUE));
  print ($ok ? "PASS" : "FAIL") . " allowed_themes=" . var_export($mode, TRUE) . " list=" . implode(",", $list) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
