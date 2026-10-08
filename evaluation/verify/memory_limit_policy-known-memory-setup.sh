#!/usr/bin/env bash
# Introspection SETUP: create a known enabled policy mlp_known_policy (memory 384M) with a
# path constraint, so an inspecting agent can read back its memory value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$s = \Drupal::entityTypeManager()->getStorage("memory_limit_policy");
if ($e = $s->load("mlp_known_policy")) { $e->delete(); }
$s->create([
  "id" => "mlp_known_policy", "label" => "MLP known policy", "memory" => "384M",
  "status" => TRUE, "weight" => 3,
  "policy_constraints" => [["id" => "path", "negate" => FALSE, "paths" => "/admin/reports/*"]],
])->save();
' >/dev/null 2>&1
echo "setup: mlp_known_policy created (memory=384M, path constraint /admin/reports/*)"
