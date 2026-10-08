#!/usr/bin/env bash
# Execution VERIFY: PASS when a password_policy 'prlp_eval_task' exists with show_policy_table===TRUE
# (so PRLP Password Policy would render its constraints table on the reset page). exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\password_policy\Entity\PasswordPolicy;
  $p = PasswordPolicy::load("prlp_eval_task");
  $show = $p ? $p->get("show_policy_table") : NULL;
  $ok = ($p && $show === TRUE);
  print ($ok ? "PASS" : "FAIL") . " exists=" . ($p ? "1" : "0") . " show_policy_table=" . var_export($show, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
