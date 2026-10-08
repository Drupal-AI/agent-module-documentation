#!/usr/bin/env bash
# Introspection CLEANUP: remove the jwtccf_eval_client credential created by
# the matching setup. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("jwt_oauth_ccf.client_repository")->deleteClient("jwtccf_eval_client");
' >/dev/null 2>&1
echo "cleanup: jwtccf_eval_client removed"
