#!/usr/bin/env bash
# Execution VERIFY: PASS when view vex_task's nid argument uses the views_extras 'cookie'
# default-argument plugin with a non-empty cookie_key. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vex_task");
  $ok = FALSE; $type = "none"; $key = "";
  if ($v) {
    $d = $v->get("display");
    $arg = $d["default"]["display_options"]["arguments"]["nid"] ?? [];
    $type = $arg["default_argument_type"] ?? "none";
    $key = $arg["default_argument_options"]["cookie_key"] ?? "";
    $ok = ($type === "cookie") && ($key !== "");
  }
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " cookie_key=" . $key . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
