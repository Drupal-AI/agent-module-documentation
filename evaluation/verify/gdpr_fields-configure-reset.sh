#!/usr/bin/env bash
# Execution RESET: remove the user gdpr_fields_config so no GDPR settings exist for user.mail
# and verify FAILS until the agent configures it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\gdpr_fields\Entity\GdprFieldConfigEntity;
  if ($c = GdprFieldConfigEntity::load("user")) { $c->delete(); }
' >/dev/null 2>&1
echo "reset: gdpr_fields_config.user cleared"
