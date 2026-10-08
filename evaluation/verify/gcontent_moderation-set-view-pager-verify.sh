#!/usr/bin/env bash
# Execution VERIFY: PASS when moderated_group_content default pager items_per_page===25. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("moderated_group_content");
  $n = $v ? ($v->get("display")["default"]["display_options"]["pager"]["options"]["items_per_page"] ?? NULL) : NULL;
  $ok = ((int) $n === 25);
  print ($ok ? "PASS" : "FAIL") . " items_per_page=" . var_export($n, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
