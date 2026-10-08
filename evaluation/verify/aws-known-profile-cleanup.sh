#!/usr/bin/env bash
# Introspection CLEANUP: delete aws_eval_profile. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("aws_profile");
  if ($p = $s->load("aws_eval_profile")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: aws_eval_profile removed"
