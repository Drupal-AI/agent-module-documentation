#!/usr/bin/env bash
# HARD VERIFY: PASS when ren_task_view has at least one display whose display_plugin is
# rest_export_nested. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("ren_task_view");
  $found = "none";
  if ($v) { foreach ($v->get("display") as $d) { if (($d["display_plugin"] ?? "") === "rest_export_nested") { $found = $d["id"]; break; } } }
  print (($found !== "none") ? "PASS" : "FAIL") . " display=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
