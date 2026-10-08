#!/usr/bin/env bash
# Execution RESET: delete the ckeditor_templates_task template so verify FAILS until the
# agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("ckeditor_templates");
  if ($t = $storage->load("ckeditor_templates_task")) { $t->delete(); }
  \Drupal::service("plugin.manager.ckeditor_template")->clearCachedDefinitions();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ckeditor_templates_task template absent"
