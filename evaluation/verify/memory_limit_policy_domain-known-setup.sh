#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_domain: create enabled policy mlp_domain_known (memory 300M) whose only
# constraint is the 'domain' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_domain_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_domain_known", "label" => "MLP domain known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"domain","negate"=>FALSE,"domains"=>["reports.example.com"]]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_domain_known created with a domain constraint"
