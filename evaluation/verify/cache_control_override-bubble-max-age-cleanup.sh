#!/usr/bin/env bash
# Execution CLEANUP: remove the cache_control_override_eval module and restore
# cache_control_override.settings to the module's shipped defaults (0 / -1).
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
    ->set("max_age.minimum", 0)
    ->set("max_age.maximum", -1)
    ->save();
' >/dev/null 2>&1
rm -rf web/modules/custom/cache_control_override_eval
drush cr >/dev/null 2>&1
echo "cleanup: cache_control_override_eval removed; settings restored to defaults (0 / -1)"
