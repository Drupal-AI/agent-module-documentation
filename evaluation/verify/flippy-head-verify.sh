#!/usr/bin/env bash
# Execution VERIFY: PASS when the Article Flippy pager adds prev/next head links
# (flippy_head_article truthy) and Flippy is enabled for Article. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("flippy.settings");
  $on = (bool) $c->get("flippy_article"); $head = (bool) $c->get("flippy_head_article");
  $ok = $on && $head;
  print ($ok ? "PASS" : "FAIL") . " flippy_article=" . var_export($on, TRUE) . " flippy_head_article=" . var_export($head, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
