#!/usr/bin/env bash
# Execution VERIFY: PASS when the compiler plugin manager has discovered a plugin with id
# 'probe_compiler'. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.compiler");
  print $m->hasDefinition("probe_compiler") ? "PASS" : "FAIL";
  print " ids=" . implode(",", array_keys($m->getDefinitions()));
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
