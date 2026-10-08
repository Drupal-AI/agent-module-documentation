#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for the "ban xmlrpc.php probes" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when at least one regex in perimeter.settings:not_found_exception_patterns
# actually matches the path "/xmlrpc.php" (i.e. a real 404 to xmlrpc.php would ban
# the IP). This is behavioural, not string-literal: any equivalent pattern passes.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $pats = \Drupal::config("perimeter.settings")->get("not_found_exception_patterns") ?: [];
  $hit = FALSE;
  foreach ($pats as $p) {
    $p = trim($p);
    if ($p !== "" && @preg_match($p, "/xmlrpc.php")) { $hit = TRUE; break; }
  }
  print ($hit ? "PASS" : "FAIL") . " matches_xmlrpc=" . ($hit?1:0) . " pattern_count=" . count($pats) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
