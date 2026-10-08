#!/usr/bin/env bash
# Execution VERIFY: PASS when the iri_task format has filter_imagestyle ENABLED and at least
# one image style selected. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ff = \Drupal\filter\Entity\FilterFormat::load("iri_task");
  if (!$ff) { print "FAIL no-format\n"; return; }
  $c = $ff->filters("filter_imagestyle")->getConfiguration();
  $status = !empty($c["status"]);
  $styles = array_keys(array_filter($c["settings"]["image_styles"] ?? []));
  $ok = $status && count($styles) >= 1;
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status,true) . " styles=" . implode(",",$styles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
