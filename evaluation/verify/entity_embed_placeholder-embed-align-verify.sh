#!/usr/bin/env bash
# Execution VERIFY: PASS when text format 'eep_news' exists with BOTH the Entity Embed filter
# ('entity_embed') and the core Align filter ('filter_align') enabled. Prints PASS/FAIL; exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("eep_news");
  $ee = $al = FALSE;
  if ($f) {
    $cfg = $f->filters()->getConfiguration();
    $ee = !empty($cfg["entity_embed"]["status"]);
    $al = !empty($cfg["filter_align"]["status"]);
  }
  $ok = ($f && $ee && $al);
  print ($ok ? "PASS" : "FAIL") . " format=" . ($f ? "eep_news" : "missing") . " entity_embed=" . var_export($ee, TRUE) . " filter_align=" . var_export($al, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
