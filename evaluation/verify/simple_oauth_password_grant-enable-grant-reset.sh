#!/usr/bin/env bash
# Execution RESET: ensure a consumer with client_id sopg_task_client exists but with the
# password grant NOT enabled (grant_types = refresh_token only), so verify FAILS until the agent
# enables the password grant on it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\consumers\Entity\Consumer;
  $cs = \Drupal::entityTypeManager()->getStorage("consumer")->loadByProperties(["client_id" => "sopg_task_client"]);
  $c = $cs ? reset($cs) : Consumer::create([
    "label" => "SOPG Task Consumer",
    "client_id" => "sopg_task_client",
    "secret" => "sopg_task_secret",
    "user_id" => 1,
    "is_default" => FALSE,
  ]);
  $c->set("grant_types", ["refresh_token"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: consumer sopg_task_client present WITHOUT password grant"
