#!/usr/bin/env bash
# Introspection CLEANUP: remove the usersjwt_eval key created by the matching
# setup. Restores baseline (uid 1 has no usersjwt_eval key). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("users_jwt.key_repository")->deleteKey("usersjwt_eval");
' >/dev/null 2>&1
echo "cleanup: usersjwt_eval key removed"
