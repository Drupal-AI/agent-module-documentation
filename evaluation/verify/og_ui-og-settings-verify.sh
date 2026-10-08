#!/usr/bin/env bash
# Execution VERIFY: PASS when og.settings has orphan deletion enabled with the cron strategy and
# group creators are no longer added automatically. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $config = \Drupal::config("og.settings");
  $delete = (bool) $config->get("delete_orphans");
  $plugin = (string) $config->get("delete_orphans_plugin_id");
  $auto = (bool) $config->get("auto_add_group_owner_membership");
  $ok = $delete && ($plugin === "cron") && !$auto;
  print ($ok ? "PASS" : "FAIL") . " delete_orphans=" . var_export($delete, TRUE) . " plugin=" .
    $plugin . " auto_add_group_owner_membership=" . var_export($auto, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
