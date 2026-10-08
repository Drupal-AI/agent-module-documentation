#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_role: create enabled policy mlp_role_known (memory 300M) whose only
# constraint is the 'role' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_role_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_role_known", "label" => "MLP role known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"role","negate"=>FALSE,"roles"=>["authenticated"=>"authenticated"]]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_role_known created with a role constraint"
