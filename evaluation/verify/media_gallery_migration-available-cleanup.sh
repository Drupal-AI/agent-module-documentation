#!/usr/bin/env bash
# Execution CLEANUP: uninstall media_gallery_migration and purge leftover migration config to restore baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pmu media_gallery_migration -y >/dev/null 2>&1
drush php:eval '
  if (!\Drupal::moduleHandler()->moduleExists("media_gallery_migration")) {
    foreach (\Drupal::configFactory()->listAll("migrate_plus.migration.d7_media_gallery") as $n) {
      $c = \Drupal::config($n);
      if (in_array("media_gallery_migration", $c->get("dependencies.enforced.module") ?: [], TRUE)) {
        \Drupal::configFactory()->getEditable($n)->delete();
      }
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media_gallery_migration uninstalled (migrations absent)"
