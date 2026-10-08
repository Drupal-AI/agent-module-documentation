#!/usr/bin/env bash
# Execution VERIFY (views_url_path_arguments default plugin): PASS when vupa_task_view's nid
# contextual filter has default_argument_type=views_url_path with segments=catalog.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vupa_task_view");
  $d = $v ? $v->get("display") : [];
  $a = $d["default"]["display_options"]["arguments"]["nid"] ?? [];
  $type = $a["default_argument_type"] ?? "";
  $seg = $a["default_argument_options"]["segments"] ?? "";
  $ok = ($type === "views_url_path" && $seg === "catalog");
  print ($ok ? "PASS" : "FAIL") . " default_argument_type=" . $type . " segments=" . $seg . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
