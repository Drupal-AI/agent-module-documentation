#!/usr/bin/env bash
# Execution RESET: ensure password_policy 'prlp_eval_task' does NOT exist, so verify FAILS until
# the agent creates it (with its constraints table shown). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\password_policy\Entity\PasswordPolicy; if ($p = PasswordPolicy::load("prlp_eval_task")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: prlp_eval_task absent"
