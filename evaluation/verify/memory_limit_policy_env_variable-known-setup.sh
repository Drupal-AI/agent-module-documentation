#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_env_variable: create enabled policy mlp_env_variable_known (memory 300M) whose only
# constraint is the 'env_variable' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_env_variable_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_env_variable_known", "label" => "MLP env_variable known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"env_variable","negate"=>FALSE,"name"=>"APP_ENV","values"=>["migration"]]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_env_variable_known created with a env_variable constraint"
