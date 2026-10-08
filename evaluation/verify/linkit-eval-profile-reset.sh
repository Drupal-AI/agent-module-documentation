#!/usr/bin/env bash
# Reset for the "create a Linkit profile with a node matcher" execution task: delete the
# eval linkit_profile config entities so the agent starts from a clean slate. Neither ships
# by default, so deleting is safe. Idempotent: no-op if already absent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["eval_profile", "eval_articles"] as $id) {
    if ($p = \Drupal::entityTypeManager()->getStorage("linkit_profile")->load($id)) { $p->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: linkit eval_profile / eval_articles profiles removed"
