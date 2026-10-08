#!/usr/bin/env bash
# Introspection SETUP: put site_settings.config into a known non-default state - the legacy
# 'flattened' loader, auto-loading ENABLED and a custom template key - so the agent must read the
# live config rather than recite the shipped defaults. Backs up the previous data to state so
# cleanup can restore it exactly. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("site_settings.config");
  \Drupal::state()->set("site_settings_eval.backup", $c->getRawData());
  $c->set("loader_plugin", "flattened")
    ->set("disable_auto_loading", FALSE)
    ->set("template_key", "ss_eval_key")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: site_settings.config loader_plugin=flattened disable_auto_loading=false template_key=ss_eval_key"
