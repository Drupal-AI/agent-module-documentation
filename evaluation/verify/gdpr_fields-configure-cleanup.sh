#!/usr/bin/env bash
# Execution CLEANUP: delete the user gdpr_fields_config entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
  if ($c = GdprFieldConfigEntity::load("user")) { $c->delete(); }
' >/dev/null 2>&1
echo "cleanup: gdpr_fields_config.user removed"
