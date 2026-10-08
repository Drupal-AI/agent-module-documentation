#!/usr/bin/env bash
# Execution VERIFY: PASS when article is selected in content_types AND watch_content is TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("paragraphs_report.settings");
  $ct = (array) $c->get("content_types");
  $watch = (bool) $c->get("watch_content");
  $article = !empty($ct["article"]);
  print (($article && $watch) ? "PASS" : "FAIL") . " article=" . var_export($article, TRUE) . " watch=" . var_export($watch, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
