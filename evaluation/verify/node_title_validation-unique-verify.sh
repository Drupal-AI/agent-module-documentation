#!/usr/bin/env bash
# Execution VERIFY: PASS when Article node titles are configured unique per content type, i.e.
# node_title_validation_config.content_types.article.unique is truthy. Prints PASS/FAIL.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cfg = \Drupal::config("node_title_validation.settings")->get("node_title_validation_config");
  $u = $cfg["content_types"]["article"]["unique"] ?? NULL;
  $ok = (bool) $u === TRUE;
  print ($ok ? "PASS" : "FAIL") . " article.unique=" . var_export($u, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
