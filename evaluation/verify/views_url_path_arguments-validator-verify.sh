#!/usr/bin/env bash
# Execution VERIFY (views_url_path_arguments validator plugin): PASS when vupa_task_view's nid
# contextual filter validates via views_url_path with segments=catalog. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vupa_task_view");
  $d = $v ? $v->get("display") : [];
  $a = $d["default"]["display_options"]["arguments"]["nid"] ?? [];
  $vt = $a["validate"]["type"] ?? "";
  $seg = $a["validate"]["options"]["views_url_path"]["segments"] ?? "";
  $ok = ($vt === "views_url_path" && $seg === "catalog");
  print ($ok ? "PASS" : "FAIL") . " validate_type=" . $vt . " segments=" . $seg . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
