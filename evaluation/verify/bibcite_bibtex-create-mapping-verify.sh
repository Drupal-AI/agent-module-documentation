#!/usr/bin/env bash
# Execution VERIFY: PASS when bibcite_entity.mapping.bibtex has format=bibtex and maps the article type to journal_article.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("bibcite_entity.mapping.bibtex");
  $types = $c->get("types") ?: [];
  $ok = ($c->get("format") === "bibtex") && (($types["article"] ?? NULL) === "journal_article");
  print ($ok ? "PASS" : "FAIL") . " format=" . var_export($c->get("format"), TRUE) . " map=" . var_export($types["article"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
