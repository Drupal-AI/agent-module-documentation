#!/usr/bin/env bash
# Introspection CLEANUP: delete jwt.config (baseline has none) and the jwt_eval_hmac Key.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  \Drupal::configFactory()->getEditable("jwt.config")->delete();
  if ($k = Key::load("jwt_eval_hmac")) { $k->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: jwt.config removed, jwt_eval_hmac deleted"
