#!/usr/bin/env bash
# Execution VERIFY: PASS when Article titles require a minimum of 15 characters, i.e.
# node_title_validation.settings node_title_validation_config.content_types.article.min == 15.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("node_title_validation.settings")->get("node_title_validation_config");
  $min = $cfg["content_types"]["article"]["min"] ?? NULL;
  $ok = ((int) $min === 15);
  print ($ok ? "PASS" : "FAIL") . " article.min=" . var_export($min, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
