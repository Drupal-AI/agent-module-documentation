#!/usr/bin/env bash
# Introspection SETUP: create a password_policy 'prlp_eval_roles' targeting the authenticated role
# with its table shown, so an agent can read which roles it applies to. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\password_policy\Entity\PasswordPolicy;
  if ($p = PasswordPolicy::load("prlp_eval_roles")) { $p->delete(); }
  PasswordPolicy::create([
    "id" => "prlp_eval_roles", "label" => "PRLP Eval Roles",
    "policy_constraints" => [], "roles" => ["authenticated" => "authenticated"],
    "show_policy_table" => TRUE, "password_reset" => 0, "send_reset_email" => FALSE, "send_pending_email" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: password_policy prlp_eval_roles roles=[authenticated]"
