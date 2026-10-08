#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_http_method: create enabled policy mlp_http_method_known (memory 300M) whose only
# constraint is the 'http_method' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_http_method_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_http_method_known", "label" => "MLP http_method known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"http_method","negate"=>FALSE,"methods"=>["post"]]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_http_method_known created with a http_method constraint"
