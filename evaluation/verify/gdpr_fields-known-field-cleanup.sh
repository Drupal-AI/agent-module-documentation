#!/usr/bin/env bash
# Introspection CLEANUP: delete the user gdpr_fields_config entity (baseline: unset). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
  if ($c = GdprFieldConfigEntity::load("user")) { $c->delete(); }
' >/dev/null 2>&1
echo "cleanup: gdpr_fields_config.user removed"
