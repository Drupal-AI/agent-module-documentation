#!/usr/bin/env bash
# Execution VERIFY: PASS when bibcite_entity.mapping.endnote7 has format=endnote7 and maps the Book type to book.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bibcite_entity.mapping.endnote7");
  $types = $c->get("types") ?: [];
  $ok = ($c->get("format") === "endnote7") && (($types["Book"] ?? NULL) === "book");
  print ($ok ? "PASS" : "FAIL") . " format=" . var_export($c->get("format"), TRUE) . " map=" . var_export($types["Book"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
