#!/usr/bin/env bash
# Introspection CLEANUP: delete the throwaway Linkit profile lml_eval_profile. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\linkit\Entity\Profile;
  if ($p = Profile::load("lml_eval_profile")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: linkit profile lml_eval_profile removed"
