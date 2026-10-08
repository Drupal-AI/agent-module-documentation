#!/usr/bin/env bash
# Execution VERIFY: PASS when field_ffs_task's file_generic widget has the 'remote' filefield source
# enabled. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c = $fd ? $fd->getComponent("field_ffs_task") : NULL;
  $s = $c["third_party_settings"]["filefield_sources"]["filefield_sources"]["sources"] ?? [];
  $ok = !empty($s["remote"]);
  print ($ok ? "PASS" : "FAIL") . " sources=" . json_encode($s) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
