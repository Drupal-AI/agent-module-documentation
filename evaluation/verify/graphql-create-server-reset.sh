#!/usr/bin/env bash
# Hard/execution reset: clear state so the build task starts from empty. Delete the
# 'eval_build' graphql_server if present (so its route is gone), then rebuild routes.
# Ensures graphql_composable is enabled so a working 'composable_example' schema is
# available for the agent to bind to.
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx graphql_composable \
  || drush en graphql_composable -y >/dev/null 2>&1
drush php:eval '
  if ($s = \Drupal\graphql\Entity\Server::load("eval_build")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: graphql_server 'eval_build' cleared; composable_example schema available"
