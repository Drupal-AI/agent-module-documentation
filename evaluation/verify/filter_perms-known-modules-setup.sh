#!/usr/bin/env bash
# Introspection SETUP: store a known module filter for user 1 (all roles, two modules).
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::keyValueExpirable("filter_perms_list")->setWithExpire("1", ["roles" => ["-1"], "modules" => ["user", "filter_perms"]], 3600);
' >/dev/null 2>&1
echo "setup: filter_perms_list[1] = roles:[-1] modules:[user,filter_perms]"
