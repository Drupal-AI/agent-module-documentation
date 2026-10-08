#!/usr/bin/env bash
# Execution VERIFY: PASS when bibcite_entity.mapping.ris has format=ris and maps the BOOK type to book.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bibcite_entity.mapping.ris");
  $types = $c->get("types") ?: [];
  $ok = ($c->get("format") === "ris") && (($types["BOOK"] ?? NULL) === "book");
  print ($ok ? "PASS" : "FAIL") . " format=" . var_export($c->get("format"), TRUE) . " map=" . var_export($types["BOOK"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
