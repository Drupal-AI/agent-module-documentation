#!/usr/bin/env bash
# Medium/introspection setup: plant a known graphql_server config entity so the agent can
# read it back from the live site. Ensures graphql_composable is enabled (provides the
# composable_example schema), then saves server 'eval_probe' at /graphql/eval-probe with
# introspection ENABLED and query_depth 7. cleanup restores baseline (no eval_probe server).
set -uo pipefail
cd /var/www/html
drush pm:list --status=enabled --field=name 2>/dev/null | grep -qx graphql_composable \
  || drush en graphql_composable -y >/dev/null 2>&1
drush php:eval '
  if ($s = \Drupal\graphql\Entity\Server::load("eval_probe")) { $s->delete(); }
  $s = \Drupal\graphql\Entity\Server::create([
    "name" => "eval_probe",
    "label" => "Eval Probe",
    "schema" => "composable_example",
    "endpoint" => "/graphql/eval-probe",
    "caching" => TRUE,
    "batching" => TRUE,
    "disable_introspection" => FALSE,
    "query_depth" => 7,
    "query_complexity" => 0,
  ]);
  $s->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: graphql_server 'eval_probe' saved (schema=composable_example, endpoint=/graphql/eval-probe, query_depth=7)"
