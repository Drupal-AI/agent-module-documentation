#!/usr/bin/env bash
# Introspection SETUP for memory_limit_policy_drush: create enabled policy mlp_drush_known (memory 300M) whose only
# constraint is the 'drush' plugin from this submodule, so an agent can read the config back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_drush_known")) { $e->delete(); }
$s->create([
  "id" => "mlp_drush_known", "label" => "MLP drush known", "memory" => "300M",
  "status" => TRUE, "weight" => 2,
  "policy_constraints" => [["id"=>"drush","negate"=>FALSE,"drush_commands"=>"cache:rebuild"]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_drush_known created with a drush constraint"
