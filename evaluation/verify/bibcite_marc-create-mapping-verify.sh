#!/usr/bin/env bash
# Execution VERIFY: PASS when bibcite_entity.mapping.marc has format=marc and maps the book type to book.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bibcite_entity.mapping.marc");
  $types = $c->get("types") ?: [];
  $ok = ($c->get("format") === "marc") && (($types["book"] ?? NULL) === "book");
  print ($ok ? "PASS" : "FAIL") . " format=" . var_export($c->get("format"), TRUE) . " map=" . var_export($types["book"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
