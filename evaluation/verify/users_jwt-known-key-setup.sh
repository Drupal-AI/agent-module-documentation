#!/usr/bin/env bash
# Introspection SETUP: save a known RSA public key for uid 1 under key id
# "usersjwt_eval" via users_jwt.key_repository, so an inspecting agent can read
# back the key id + algorithm. Idempotent (re-saving the same id/uid is fine).
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $pem = file_get_contents(DRUPAL_ROOT . "/modules/contrib/jwt/modules/users_jwt/tests/fixtures/users_jwt_rsa1-public.pem");
  \Drupal::service("users_jwt.key_repository")->saveKey(1, "usersjwt_eval", "RS256", $pem);
' >/dev/null 2>&1
echo "setup: uid 1 has users_jwt key usersjwt_eval (RS256)"
