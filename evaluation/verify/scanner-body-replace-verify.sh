#!/usr/bin/env bash
# Live-state verification for the scanner body-replace task.
# PASS iff the Article "Eval Scanner Node" body now contains "Globex Inc" and no longer
# contains "Acme Corporation" (case-insensitive). Exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'error_reporting(0);
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "Eval Scanner Node"]);
  if (!$nodes) { print "FAIL no-node\n"; }
  else {
    $n = \Drupal::entityTypeManager()->getStorage("node")->loadUnchanged(reset($nodes)->id());
    $body = (string) $n->body->value;
    $ok = (strpos($body, "Globex Inc") !== FALSE) && (stripos($body, "Acme Corporation") === FALSE);
    print ($ok ? "PASS" : "FAIL") . " body=[" . $body . "]\n";
  }
' 2>/dev/null)
line=$(echo "$out" | grep -aoE '^(PASS|FAIL).*' | head -1)
[ -z "$line" ] && line=$(echo "$out" | grep -aoE '(PASS|FAIL).*' | head -1)
echo "$line"
case "$line" in PASS*) exit 0;; *) exit 1;; esac
