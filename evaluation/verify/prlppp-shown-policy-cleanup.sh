#!/usr/bin/env bash
# Introspection CLEANUP: delete the prlp_eval_policy password policy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\password_policy\Entity\PasswordPolicy; if ($p = PasswordPolicy::load("prlp_eval_policy")) { $p->delete(); }' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: prlp_eval_policy removed"
