#!/usr/bin/env bash
# Hard (execution) reset: clear any policy the agent is asked to build so the verify
# script FAILs on empty state. Deletes the target policy id and any leftover probe.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("password_policy");
  foreach (["strong_password", "ps_eval_probe"] as $id) {
    if ($e = $s->load($id)) { $e->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: password policy 'strong_password' cleared"
