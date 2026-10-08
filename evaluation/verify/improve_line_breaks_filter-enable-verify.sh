#!/usr/bin/env bash
# Execution VERIFY: PASS when the improve_line_breaks_filter is enabled (status TRUE) on the
# ilbf_task text format. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("ilbf_task");
  $status = NULL;
  if ($format) {
    $filters = $format->filters();
    if ($filters->has("improve_line_breaks_filter")) {
      $status = (bool) $filters->get("improve_line_breaks_filter")->status;
    }
  }
  $ok = ($status === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
