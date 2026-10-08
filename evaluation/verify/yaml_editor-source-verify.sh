#!/usr/bin/env bash
# Live-state verification for the "self-host Ace" task: yaml_editor.config editor_source must
# point at the local library path /libraries/ace/ace.min.js (and no longer at cdnjs).
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $src = (string) \Drupal::config("yaml_editor.config")->get("editor_source");
  $ok = ($src === "/libraries/ace/ace.min.js");
  print ($ok ? "PASS" : "FAIL") . " editor_source=" . $src . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
