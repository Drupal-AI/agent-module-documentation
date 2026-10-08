#!/usr/bin/env bash
# Execution VERIFY: PASS when a custom Anonymizer plugin with id anonymizer_eval_static is
# discoverable by the anonymizer plugin manager. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $m = \Drupal::service("plugin.manager.anonymizer");
  $m->clearCachedDefinitions();
  $has = $m->hasDefinition("anonymizer_eval_static");
  print ($has ? "PASS" : "FAIL") . " has_plugin=" . var_export($has, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
