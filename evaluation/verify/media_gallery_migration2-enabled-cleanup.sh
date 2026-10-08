#!/usr/bin/env bash
# Introspection CLEANUP: uninstall media_gallery_migration2 and purge any leftover enforced migration config.
# Restores baseline (submodule disabled, no gallery migration config). Idempotent. Exit 0.
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
echo "cleanup: media_gallery_migration2 uninstalled and its migration config purged"
