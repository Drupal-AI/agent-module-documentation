#!/usr/bin/env bash
# Execution VERIFY: PASS when a toc_type toc_api_numbered exists whose default numbering type
# (options.default.number_type) is 'upper-roman'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\toc_api\Entity\TocType;
  $t = TocType::load("toc_api_numbered");
  $o = $t ? $t->getOptions() : [];
  $nt = $o["default"]["number_type"] ?? "";
  $ok = ($t && $nt === "upper-roman");
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($t ? "1" : "0") . " number_type=" . var_export($nt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
