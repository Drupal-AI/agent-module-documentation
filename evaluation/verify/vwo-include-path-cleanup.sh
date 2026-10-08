#!/usr/bin/env bash
# Execution RESET: restore shipped vwo.settings defaults (filter.page.type listexclude, list NULL)
# so verify FAILS until the agent restricts the snippet to /vwo-landing. Idempotent. Exit 0.
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
echo "reset: vwo.settings filter.page defaults (listexclude, no list)"
