#!/usr/bin/env bash
# Execution VERIFY: PASS when the base_url field on views.view.views_base_url_link_task has
# show_link === TRUE and a non-empty show_link_options.link_path. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $f = \Drupal::config("views.view.views_base_url_link_task")->get("display.default.display_options.fields.base_url") ?: [];
  $show = $f["show_link"] ?? NULL;
  $path = $f["show_link_options"]["link_path"] ?? "";
  $ok = (($show === TRUE || $show === 1 || $show === "1") && !empty($path));
  print ($ok ? "PASS" : "FAIL") . " show_link=" . var_export($show, TRUE) . " link_path=" . var_export($path, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
