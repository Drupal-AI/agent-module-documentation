#!/usr/bin/env bash
# Execution RESET: force baseline by uninstalling media_gallery_migration2 and purging any leftover enforced migration
# config, so verify FAILS until the agent enables the submodule. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu media_gallery_migration2 -y >/dev/null 2>&1
drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("media_gallery_migration2")) {
    foreach (\Drupal::configFactory()->listAll("migrate_plus.migration.d7_media_gallery") as $n) {
      $c = \Drupal::config($n);
      if (in_array("media_gallery_migration2", $c->get("dependencies.enforced.module") ?: [], TRUE)) {
        \Drupal::configFactory()->getEditable($n)->delete();
      }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: media_gallery_migration2 uninstalled (migrations absent)"
