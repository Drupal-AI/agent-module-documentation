#!/usr/bin/env bash
# Execution VERIFY: PASS when text format ace_editor_h2 has the ace_filter enabled with
# settings.syntax=ruby. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("ace_editor_h2");
  $status = NULL; $syntax = NULL;
  if ($f && $f->filters()->has("ace_filter")) {
    $flt = $f->filters()->get("ace_filter");
    $status = (bool) $flt->status;
    $cfg = $flt->getConfiguration();
    $syntax = $cfg["settings"]["syntax"] ?? NULL;
  }
  $ok = ($status === TRUE && $syntax === "ruby");
  print ($ok ? "PASS" : "FAIL") . " ace_filter_status=" . var_export($status, TRUE) . " syntax=" . var_export($syntax, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
