#!/usr/bin/env bash
# Introspection CLEANUP: restore the exact site_settings.config data saved by the matching setup
# (falling back to the post-install defaults: full loader, auto-loading disabled, template key
# site_settings). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $backup = \Drupal::state()->get("site_settings_eval.backup");
  $c = \Drupal::configFactory()->getEditable("site_settings.config");
  if (is_array($backup) && $backup) {
    unset($backup["_core"]);
    foreach ($backup as $k => $v) { $c->set($k, $v); }
    $c->save();
  }
  else {
    $c->set("loader_plugin", "full")
      ->set("disable_auto_loading", TRUE)
      ->set("template_key", "site_settings")
      ->save();
  }
  \Drupal::state()->delete("site_settings_eval.backup");
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: site_settings.config restored"
