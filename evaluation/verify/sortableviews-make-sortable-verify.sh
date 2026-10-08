#!/usr/bin/env bash
# Execution VERIFY: PASS when sortableviews_task's default display uses one of the sortable
# styles (sortable_default/sortable_html_list/sortable_table) with a non-empty weight_field.
# exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("sortableviews_task");
  $style = "none"; $wf = "";
  if ($v) {
    $d = $v->get("display");
    $style = $d["default"]["display_options"]["style"]["type"] ?? "none";
    $wf = $d["default"]["display_options"]["style"]["options"]["weight_field"] ?? "";
  }
  $sortable = in_array($style, ["sortable_default","sortable_html_list","sortable_table"], TRUE);
  $ok = ($sortable && $wf !== "");
  print ($ok ? "PASS" : "FAIL") . " style=" . $style . " weight_field=" . var_export($wf, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
