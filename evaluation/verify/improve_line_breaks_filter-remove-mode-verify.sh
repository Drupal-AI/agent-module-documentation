#!/usr/bin/env bash
# Execution VERIFY: PASS when improve_line_breaks_filter on ilbf_remove is enabled AND its
# remove_empty_paragraphs setting is TRUE (delete mode). Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("ilbf_remove");
  $status = NULL; $remove = NULL;
  if ($format) {
    $filters = $format->filters();
    if ($filters->has("improve_line_breaks_filter")) {
      $f = $filters->get("improve_line_breaks_filter");
      $status = (bool) $f->status;
      $remove = $f->settings["remove_empty_paragraphs"] ?? NULL;
    }
  }
  $ok = ($status === TRUE && (bool) $remove === TRUE);
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status, TRUE) . " remove_empty_paragraphs=" . var_export($remove, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
