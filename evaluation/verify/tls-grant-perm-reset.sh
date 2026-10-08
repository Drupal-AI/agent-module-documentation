#!/usr/bin/env bash
# Execution RESET: ensure role tls_task_role exists WITHOUT the switcher permission, so verify FAILS
# until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("tls_task_role") ?: Role::create(["id" => "tls_task_role", "label" => "TLS Task Role"]);
  $r->revokePermission("use toolbar_language_switcher");
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role tls_task_role WITHOUT use toolbar_language_switcher"
