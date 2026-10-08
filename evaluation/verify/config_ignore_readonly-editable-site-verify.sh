#!/usr/bin/env bash
# Execution VERIFY: PASS when config_ignore_readonly's readonly whitelist (the patterns it
# forwards to config_readonly) contains system.site -- i.e. the Basic site settings form is
# editable under readonly. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = \Drupal::moduleHandler()->invoke("config_ignore_readonly", "config_readonly_whitelist_patterns") ?: [];
  $ok = in_array("system.site", $p, TRUE);
  print ($ok ? "PASS" : "FAIL") . " whitelist_has_system_site=" . var_export($ok, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
