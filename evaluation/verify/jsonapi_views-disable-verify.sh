#!/usr/bin/env bash
# Execution VERIFY: PASS when the jav_task default display has the jsonapi_views extender
# enabled === false (exposure turned OFF).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("jav_task");
  $en = NULL;
  if ($v) { $d = $v->getDisplay("default"); $en = $d["display_options"]["display_extenders"]["jsonapi_views"]["enabled"] ?? NULL; }
  $ok = ($en === FALSE || $en === 0 || $en === "0");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
