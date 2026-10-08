#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ffs_ref's widget has the 'reference' filefield source enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ffs_ref") : NULL;
  $s = $c["third_party_settings"]["filefield_sources"]["filefield_sources"]["sources"] ?? [];
  $ok = !empty($s["reference"]);
  print ($ok ? "PASS" : "FAIL") . " sources=" . json_encode($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
