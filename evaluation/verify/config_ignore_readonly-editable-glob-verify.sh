#!/usr/bin/env bash
# Execution VERIFY: PASS when config_ignore_readonly's readonly whitelist contains a pattern
# that makes system.rss editable under readonly -- either the exact name system.rss or a glob
# (system.* / system.rss*) covering it. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::moduleHandler()->invoke("config_ignore_readonly", "config_readonly_whitelist_patterns") ?: [];
  $ok = FALSE;
  foreach ($p as $pat) {
    if (fnmatch($pat, "system.rss")) { $ok = TRUE; break; }
  }
  print ($ok ? "PASS" : "FAIL") . " patterns=" . implode("|", $p) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
