#!/usr/bin/env bash
# Execution RESET for "switch signing algorithm to HS512". Establishes a baseline where JWT
# signs with an HS256 key `jwt_task_alg`, so verify (which requires the effective algorithm to
# be HS512) FAILS until the agent reconfigures. Recreates the key fresh as HS256. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\key\Entity\Key;
  if ($k = Key::load("jwt_task_alg")) { $k->delete(); }
  Key::create([
    "id" => "jwt_task_alg", "label" => "JWT Task Alg",
    "key_type" => "jwt_hs", "key_type_settings" => ["algorithm" => "HS256"],
    "key_provider" => "config",
    "key_provider_settings" => ["key_value" => str_repeat("t", 128)],
  ])->save();
  \Drupal::configFactory()->getEditable("jwt.config")->set("key_id", "jwt_task_alg")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: jwt.config key_id=jwt_task_alg, algorithm HS256 (verify wants HS512)"
