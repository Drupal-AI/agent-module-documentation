#!/usr/bin/env bash
# Introspection CLEANUP: delete the template config entity created by the matching setup.
# Restores baseline (no ckeditor_templates entities). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("ckeditor_templates");
  if ($t = $storage->load("ckeditor_templates_promo")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor_templates_promo removed"
