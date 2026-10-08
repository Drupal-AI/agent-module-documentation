#!/usr/bin/env bash
# Execution VERIFY: PASS when views_natural_sort_demo default Title sort is plugin_id 'natural', order 'NASC'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("views_natural_sort_demo");
  $s = $v ? ($v->get("display")["default"]["display_options"]["sorts"]["title"] ?? []) : [];
  $pid = $s["plugin_id"] ?? "none";
  $order = $s["order"] ?? "none";
  $ok = ($pid === "natural") && ($order === "NASC");
  print ($ok ? "PASS" : "FAIL") . " plugin_id=$pid order=$order\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
