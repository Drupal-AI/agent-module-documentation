#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_path: create enabled policy mlp_path_known (memory 300M) whose only
# constraint is the 'path' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_path_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_path_known", "label" => "MLP path known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"path","negate"=>FALSE,"paths"=>"/user/*"]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_path_known created with a path constraint"
