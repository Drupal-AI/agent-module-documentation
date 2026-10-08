#!/usr/bin/env bash
# Medium (introspection) setup: create a known Password Policy that uses the
# password_strength constraint at a specific minimum score, so the agent can inspect
# the live site and report it. Idempotent: deletes any prior probe policy first.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("password_policy");
  if ($e = $s->load("ps_eval_probe")) { $e->delete(); }
  $s->create([
    "id" => "ps_eval_probe",
    "label" => "PS Eval Probe",
    "password_reset" => 0,
    "policy_constraints" => [
      ["id" => "password_strength_constraint", "strength_score" => 3],
    ],
    "roles" => ["authenticated" => "authenticated"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: password policy 'ps_eval_probe' with password_strength_constraint strength_score=3"
