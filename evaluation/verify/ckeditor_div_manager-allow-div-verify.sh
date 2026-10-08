#!/usr/bin/env bash
# Execution VERIFY for "allow the <div> tag in the cdm_filter format's filter_html".
# PASS when the filter_html allowed_html string on filter.format.cdm_filter contains a
# <div ...> tag. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $ff = FilterFormat::load("cdm_filter");
  $allowed = "";
  if ($ff) {
    $cfg = $ff->filters("filter_html")->getConfiguration();
    $allowed = $cfg["settings"]["allowed_html"] ?? "";
  }
  $ok = (bool) preg_match("/<div(\s|>)/", $allowed);
  print ($ok ? "PASS" : "FAIL") . " allowed_html=" . $allowed . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
