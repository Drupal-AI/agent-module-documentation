#!/usr/bin/env bash
# Execution VERIFY: PASS when pages_restriction.settings contains a mapping line restricting
# 'pr-locked' to target 'pr-redirect' (i.e. a line "pr-locked|pr-redirect"). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $val = (string) \Drupal::config("pages_restriction.settings")->get("pages_restriction");
  $ok = FALSE;
  foreach (preg_split("/\r\n|\r|\n/", $val) as $line) {
    $line = trim($line);
    $parts = array_map("trim", explode("|", $line));
    if (count($parts) === 2 && $parts[0] === "pr-locked" && $parts[1] === "pr-redirect") { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL") . " value=[" . str_replace(["\r","\n"], ["","; "], $val) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
