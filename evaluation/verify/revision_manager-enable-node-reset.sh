#!/usr/bin/env bash
# Shared CLEANUP/RESET: restore revision_manager.settings to its shipped install defaults
# (nothing enabled, no defaults). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("revision_manager.settings");
  $c->set("enabled_entities", [])
    ->set("defaults", [])
    ->set("disable_automatic_queueing", FALSE)
    ->set("verbose_log", FALSE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "restore: revision_manager.settings back to shipped defaults"
