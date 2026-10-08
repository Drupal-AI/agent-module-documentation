#!/usr/bin/env bash
# Execution VERIFY: PASS when a view 'vjs_task' exists whose default display uses the
# views_json_source_query backend with row_apath 'data/nodes'. Exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vjs_task");
  $ok = FALSE; $qtype = "none"; $apath = "none";
  if ($v) {
    $d = $v->get("display")["default"]["display_options"]["query"] ?? [];
    $qtype = $d["type"] ?? "none";
    $apath = $d["options"]["row_apath"] ?? "none";
    $ok = ($qtype === "views_json_source_query" && $apath === "data/nodes");
  }
  print ($ok ? "PASS" : "FAIL") . " query=" . $qtype . " row_apath=" . $apath . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
