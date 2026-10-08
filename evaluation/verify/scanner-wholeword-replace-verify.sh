#!/usr/bin/env bash
# Live-state verification for the scanner WHOLE-WORD replace task.
# Expected final body: "The dog sat by a category of cats."
# PASS iff body contains "dog sat", still contains "category" and "cats", and no longer
# contains the standalone phrase "cat sat" (proves only the whole word was replaced).
# Exits 0/1. No arguments.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval 'error_reporting(0);
  $nodes = \Drupal::entityTypeManager()->getStorage("node")->loadByProperties(["title" => "Eval Scanner Wholeword"]);
  if (!$nodes) { print "FAIL no-node\n"; }
  else {
    $n = \Drupal::entityTypeManager()->getStorage("node")->loadUnchanged(reset($nodes)->id());
    $body = (string) $n->body->value;
    $ok = (strpos($body, "dog sat") !== FALSE)
       && (strpos($body, "category") !== FALSE)
       && (strpos($body, "cats") !== FALSE)
       && (strpos($body, "cat sat") === FALSE);
    print ($ok ? "PASS" : "FAIL") . " body=[" . $body . "]\n";
  }
' 2>/dev/null)
line=$(echo "$out" | grep -aoE '^(PASS|FAIL).*' | head -1)
[ -z "$line" ] && line=$(echo "$out" | grep -aoE '(PASS|FAIL).*' | head -1)
echo "$line"
case "$line" in PASS*) exit 0;; *) exit 1;; esac
