#!/usr/bin/env bash
# Introspection SETUP: snapshot gin_lb.settings, then set toastify_loading to 'custom'
# ("Do not load"), which makes gin_lb stop attaching the gin_lb/gin_lb_toastify library and stop
# adding a toastify dependency in hook_library_info_alter(). The agent must read the live config
# to report this. The matching cleanup restores the snapshot. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $state = \Drupal::state();
  if (!$state->get("gin_lb_eval.toastify_backup")) {
    $state->set("gin_lb_eval.toastify_backup", $cf->get("gin_lb.settings")->getRawData());
  }
  $cf->getEditable("gin_lb.settings")->set("toastify_loading", "custom")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: gin_lb.settings toastify_loading=custom"
