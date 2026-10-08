#!/usr/bin/env bash
# Introspection SETUP: create a jwt_hs Key `jwt_eval_alg` using algorithm HS512 and point
# jwt.config at it, so the agent must read the *key's* algorithm (not jwt.config) to answer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if (!Key::load("jwt_eval_alg")) {
    Key::create([
      "id" => "jwt_eval_alg", "label" => "JWT Eval Alg",
      "key_type" => "jwt_hs", "key_type_settings" => ["algorithm" => "HS512"],
      "key_provider" => "config",
      "key_provider_settings" => ["key_value" => str_repeat("a", 128)],
    ])->save();
  }
  \Drupal::configFactory()->getEditable("jwt.config")->set("key_id", "jwt_eval_alg")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: jwt.config key_id=jwt_eval_alg, key algorithm HS512"
