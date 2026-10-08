#!/usr/bin/env bash
# Medium (introspection) cleanup: remove the known probe policy, restoring baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("password_policy")->load("ps_eval_probe")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: password policy 'ps_eval_probe' removed"
