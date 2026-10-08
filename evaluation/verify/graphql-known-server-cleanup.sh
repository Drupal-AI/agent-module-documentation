#!/usr/bin/env bash
# Medium/introspection cleanup: remove the planted 'eval_probe' graphql_server so the site
# returns to baseline (no eval servers). Leaves graphql_composable enabled (harmless).
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($s = \Drupal\graphql\Entity\Server::load("eval_probe")) { $s->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: graphql_server 'eval_probe' removed"
