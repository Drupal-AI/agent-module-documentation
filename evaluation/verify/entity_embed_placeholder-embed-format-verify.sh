#!/usr/bin/env bash
# Execution VERIFY: PASS when a text format 'eep_fmt' exists and has the Entity Embed filter
# (id 'entity_embed', provided by entity_embed) enabled. This is the pipeline whose CKEditor
# preview entity_embed_placeholder styles. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $f = FilterFormat::load("eep_fmt");
  $on = FALSE;
  if ($f) {
    $cfg = $f->filters()->getConfiguration();
    $on = !empty($cfg["entity_embed"]["status"]);
  }
  $ok = ($f && $on);
  print ($ok ? "PASS" : "FAIL") . " format=" . ($f ? "eep_fmt" : "missing") . " entity_embed=" . var_export($on, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
