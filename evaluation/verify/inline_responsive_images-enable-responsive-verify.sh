#!/usr/bin/env bash
# Execution VERIFY: PASS when iri_rtask has filter_responsive_image_style ENABLED and at least
# one responsive image style selected. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ff = \Drupal\filter\Entity\FilterFormat::load("iri_rtask");
  if (!$ff) { print "FAIL no-format\n"; return; }
  $c = $ff->filters("filter_responsive_image_style")->getConfiguration();
  $status = !empty($c["status"]);
  $styles = array_keys(array_filter($c["settings"]["image_styles"] ?? []));
  $ok = $status && count($styles) >= 1;
  print ($ok ? "PASS" : "FAIL") . " status=" . var_export($status,true) . " styles=" . implode(",",$styles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
