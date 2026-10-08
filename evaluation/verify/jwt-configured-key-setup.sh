#!/usr/bin/env bash
# Introspection SETUP: create a jwt_hs (HS256) Key entity `jwt_eval_hmac` and point
# jwt.config->key_id at it, so an inspecting agent can read back which key JWT signs with.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if (!Key::load("jwt_eval_hmac")) {
    Key::create([
      "id" => "jwt_eval_hmac", "label" => "JWT Eval HMAC",
      "key_type" => "jwt_hs", "key_type_settings" => ["algorithm" => "HS256"],
      "key_provider" => "config",
      "key_provider_settings" => ["key_value" => str_repeat("e", 64)],
    ])->save();
  }
  \Drupal::configFactory()->getEditable("jwt.config")->set("key_id", "jwt_eval_hmac")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jwt.config key_id=jwt_eval_hmac (key type jwt_hs, HS256)"
