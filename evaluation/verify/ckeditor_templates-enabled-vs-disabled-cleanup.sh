#!/usr/bin/env bash
# Introspection CLEANUP: delete both template config entities created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("ckeditor_templates");
  foreach (["ckeditor_templates_live", "ckeditor_templates_draft"] as $id) {
    if ($t = $storage->load($id)) { $t->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor_templates_live / ckeditor_templates_draft removed"
