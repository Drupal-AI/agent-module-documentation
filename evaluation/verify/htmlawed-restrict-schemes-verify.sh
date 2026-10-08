#!/usr/bin/env bash
# Execution VERIFY: PASS when filter_htmlawed config on htmlawed_schemes contains a schemes
# rule limiting protocols (config string contains 'schemes' and 'mailto'). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("htmlawed_schemes");
  $cfg = $f ? $f->filters("filter_htmlawed")->getConfiguration() : NULL;
  $c = strtolower($cfg["settings"]["config"] ?? "");
  $ok = strpos($c, "schemes") !== FALSE && strpos($c, "mailto") !== FALSE;
  print (($ok) ? "PASS" : "FAIL") . " config=" . ($cfg["settings"]["config"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
