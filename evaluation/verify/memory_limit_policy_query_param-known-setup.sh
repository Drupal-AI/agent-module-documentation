#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_query_param: create enabled policy mlp_query_param_known (memory 300M) whose only
# constraint is the 'query_param' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_query_param_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_query_param_known", "label" => "MLP query_param known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"query_param","negate"=>FALSE,"query_param"=>"debug"]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_query_param_known created with a query_param constraint"
