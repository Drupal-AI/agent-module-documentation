#!/usr/bin/env bash
# Execution VERIFY for "make term-based access control apply to non-node entities that reference
# terms of the pbe_task_vocab vocabulary".
# PASS when the permissions_by_entity module is installed AND
# permissions_by_term.settings:target_bundles contains exactly pbe_task_vocab (a non-empty
# intersecting list is a hard prerequisite for AccessChecker::isAccessControlled()).
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $enabled = \Drupal::moduleHandler()->moduleExists("permissions_by_entity");
  $bundles = array_values(array_filter((array) \Drupal::config("permissions_by_term.settings")->get("target_bundles")));
  $ok = $enabled && $bundles === ["pbe_task_vocab"];
  print ($ok ? "PASS" : "FAIL") . " module_enabled=" . var_export($enabled, TRUE)
    . " target_bundles=" . json_encode($bundles) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
