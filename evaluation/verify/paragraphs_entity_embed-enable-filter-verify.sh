#!/usr/bin/env bash
# Execution VERIFY: PASS when the pee_exec text format has the paragraphs_entity_embed filter
# enabled (status TRUE). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("pee_exec");
  $status = NULL;
  if ($f && $f->filters()->has("paragraphs_entity_embed")) { $status = $f->filters("paragraphs_entity_embed")->status; }
  $ok = ($status === TRUE || $status === 1);
  print ($ok ? "PASS" : "FAIL") . " filter_status=" . var_export($status, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
