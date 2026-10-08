#!/usr/bin/env bash
# Execution VERIFY (epk H2): PASS when a text format 'epk_new' exists AND has the
# emptyparagraphkiller filter enabled. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("epk_new");
  $status = \Drupal::config("filter.format.epk_new")->get("filters.emptyparagraphkiller.status");
  $ok = $f && ($status === TRUE || $status === 1 || $status === "1");
  print ($ok ? "PASS" : "FAIL")." exists=".var_export((bool)$f,TRUE)." status=".var_export($status,TRUE)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
