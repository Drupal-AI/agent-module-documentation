#!/usr/bin/env bash
# Introspection SETUP: create a password_policy 'prlp_eval_policy' whose constraints table is set
# to show (show_policy_table=true) — which PRLP Password Policy would render on the reset page —
# so an agent can find it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\password_policy\Entity\PasswordPolicy;
  if ($p = PasswordPolicy::load("prlp_eval_policy")) { $p->delete(); }
  PasswordPolicy::create([
    "id" => "prlp_eval_policy", "label" => "PRLP Eval Policy",
    "policy_constraints" => [], "roles" => ["authenticated" => "authenticated"],
    "show_policy_table" => TRUE, "password_reset" => 0, "send_reset_email" => FALSE, "send_pending_email" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: password_policy.password_policy.prlp_eval_policy show_policy_table=true"
