#!/usr/bin/env bash
# Execution RESET for the "bubble a real max-age" case.
# Removes the cache_control_override_eval custom module (uninstall first, then purge any
# leftover core.extension / system.schema entry, then delete the directory) and sets
# cache_control_override.settings to clamps that WOULD distort a 45 second max-age
# (floor 600, ceiling 1200), so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall cache_control_override_eval -y >/dev/null 2>&1 || true
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("core.extension");
  $modules = $config->get("module") ?: [];
  if (array_key_exists("cache_control_override_eval", $modules)) {
    unset($modules["cache_control_override_eval"]);
    $config->set("module", $modules)->save();
  }
  \Drupal::keyValue("system.schema")->delete("cache_control_override_eval");
  \Drupal::configFactory()->getEditable("cache_control_override.settings")
    ->set("max_age.minimum", 600)
    ->set("max_age.maximum", 1200)
    ->save();
' >/dev/null 2>&1
rm -rf web/modules/custom/cache_control_override_eval
drush cr >/dev/null 2>&1
echo "reset: cache_control_override_eval removed; clamps set to minimum 600 / maximum 1200"
