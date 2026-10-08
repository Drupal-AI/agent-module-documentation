#!/usr/bin/env bash
# Execution VERIFY: PASS when filter.format.ibw_build_fmt exists with ib_dam_wysiwyg enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("filter.format.ibw_build_fmt");
  $status = $c->get("filters.ib_dam_wysiwyg.status");
  $exists = !$c->isNew();
  $ok = ($exists && (bool) $status === TRUE && $status !== NULL);
  print ($ok ? "PASS" : "FAIL") . " exists=" . var_export($exists, TRUE) . " ib_dam_wysiwyg_status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
