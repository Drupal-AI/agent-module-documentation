#!/usr/bin/env bash
# Execution VERIFY (epk H1): PASS when the emptyparagraphkiller filter is enabled (status TRUE)
# on the epk_task text format. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $status = \Drupal::config("filter.format.epk_task")->get("filters.emptyparagraphkiller.status");
  $ok = ($status === TRUE || $status === 1 || $status === "1");
  print ($ok ? "PASS" : "FAIL")." status=".var_export($status,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
