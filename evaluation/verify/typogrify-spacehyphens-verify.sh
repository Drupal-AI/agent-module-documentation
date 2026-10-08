#!/usr/bin/env bash
# Execution VERIFY: PASS when the Typogrify filter on typogrify_eval_h2 has space_hyphens = 1
# (stand-alone dashes replaced by em-dashes). Prints PASS/FAIL. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("typogrify_eval_h2");
  $val = NULL;
  if ($f) {
    $filters = $f->get("filters") ?: [];
    $val = $filters["typogrify"]["settings"]["space_hyphens"] ?? NULL;
  }
  $ok = ((int) $val === 1);
  print ($ok ? "PASS" : "FAIL") . " space_hyphens=" . var_export($val, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
