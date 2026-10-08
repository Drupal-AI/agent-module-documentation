#!/usr/bin/env bash
# Execution VERIFY: PASS when sahef_task has html_element_filter with css_selectors containing
# .sidebar-filters (or the bare class 'sidebar-filters'). Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ps = \Drupal::config("search_api.index.sahef_task")->get("processor_settings") ?? [];
  $sel = $ps["html_element_filter"]["css_selectors"] ?? NULL;
  $ok = is_string($sel) && strpos($sel, "sidebar-filters") !== FALSE;
  print ($ok ? "PASS" : "FAIL") . " css_selectors=" . var_export($sel, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
