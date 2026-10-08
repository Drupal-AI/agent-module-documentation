#!/usr/bin/env bash
# Introspection SETUP: store a known filter_perms selection for user 1 in the expirable key/value
# collection filter_perms_list, so an agent can read back which modules/roles are filtered.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::keyValueExpirable("filter_perms_list")->setWithExpire("1", ["roles" => ["fperm_editor"], "modules" => ["node"]], 3600);
' >/dev/null 2>&1
echo "setup: filter_perms_list[1] = roles:[fperm_editor] modules:[node]"
