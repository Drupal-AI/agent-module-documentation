#!/usr/bin/env bash
# Execution CLEANUP: delete the prlp_eval_task password policy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\password_policy\Entity\PasswordPolicy; if ($p = PasswordPolicy::load("prlp_eval_task")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: prlp_eval_task removed"
