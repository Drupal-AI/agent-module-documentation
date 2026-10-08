#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_route: create enabled policy mlp_route_known (memory 300M) whose only
# constraint is the 'route' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_route_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_route_known", "label" => "MLP route known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"route","negate"=>FALSE,"routes"=>["system.admin"]]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_route_known created with a route constraint"
