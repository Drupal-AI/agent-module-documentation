#!/usr/bin/env bash
# Execution VERIFY: PASS when an Article 'RLD Hard Created' exists and its (auto-generated)
# revision log message reports creation.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "RLD Hard Created", "type" => "article"]);
  $n = $nodes ? reset($nodes) : NULL;
  $msg = $n ? (string) $n->getRevisionLogMessage() : "";
  $ok = ($n && stripos($msg, "Created new") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " msg=" . var_export($msg, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
