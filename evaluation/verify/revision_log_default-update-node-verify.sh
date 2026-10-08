#!/usr/bin/env bash
# Execution VERIFY: PASS when the node has been retitled to 'RLD Hard Update EDITED', has >=2
# revisions, and the latest revision log message auto-reports the Title field change.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("node");
  $nodes = $storage->loadByProperties(["title" => "RLD Hard Update EDITED", "type" => "article"]);
  $n = $nodes ? reset($nodes) : NULL;
  $msg = $n ? (string) $n->getRevisionLogMessage() : "";
  $revs = $n ? count($storage->revisionIds($n)) : 0;
  $ok = ($n && $revs >= 2 && stripos($msg, "Updated") !== FALSE && stripos($msg, "Title") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " revs=$revs msg=" . var_export($msg, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
