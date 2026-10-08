#!/usr/bin/env bash
# Execution VERIFY: PASS when remote_audio source_configuration.providers is exactly ['Spotify'].
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::config("media.type.remote_audio")->get("source_configuration")["providers"] ?? [];
  $vals = array_values($p);
  $ok = (count($vals) === 1 && $vals[0] === "Spotify");
  print ($ok ? "PASS" : "FAIL") . " providers=" . json_encode($vals) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
