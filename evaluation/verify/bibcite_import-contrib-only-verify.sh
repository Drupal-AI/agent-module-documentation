#!/usr/bin/env bash
# Execution VERIFY: PASS when contributor_deduplication is TRUE and keyword_deduplication is FALSE.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bibcite_import.settings");
  $ok = ($c->get("settings.contributor_deduplication") === TRUE) && ($c->get("settings.keyword_deduplication") === FALSE);
  print ($ok ? "PASS" : "FAIL") . " contrib=" . var_export($c->get("settings.contributor_deduplication"), TRUE) . " kw=" . var_export($c->get("settings.keyword_deduplication"), TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
