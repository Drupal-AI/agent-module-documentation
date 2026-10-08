#!/usr/bin/env bash
# Execution RESET: create a password_policy 'prlp_eval_toggle' with show_policy_table=FALSE so
# verify FAILS until the agent turns the constraints table on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\password_policy\Entity\PasswordPolicy;
  if ($p = PasswordPolicy::load("prlp_eval_toggle")) { $p->delete(); }
  PasswordPolicy::create([
    "id" => "prlp_eval_toggle", "label" => "PRLP Eval Toggle",
    "policy_constraints" => [], "roles" => ["authenticated" => "authenticated"],
    "show_policy_table" => FALSE, "password_reset" => 0, "send_reset_email" => FALSE, "send_pending_email" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: prlp_eval_toggle present with show_policy_table=false"
