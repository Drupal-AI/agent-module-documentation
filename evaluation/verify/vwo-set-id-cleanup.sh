#!/usr/bin/env bash
# Execution RESET: restore shipped vwo.settings defaults (id NULL) so verify FAILS until the agent
# sets the account id. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("vwo.settings");
  $c->setData([
    "id" => NULL, "is_wingify_account" => NULL, "coll_url" => NULL,
    "filter" => ["enabled" => "on", "userconfig" => "nocontrol", "nodetypes" => [], "page" => ["type" => "listexclude", "list" => NULL], "roles" => []],
    "loading" => ["type" => "async", "timeout" => ["settings" => 2000, "library" => 2500], "usejquery" => "import"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: vwo.settings id = NULL (defaults)"
