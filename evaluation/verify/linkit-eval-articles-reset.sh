#!/usr/bin/env bash
# Reset for the "Linkit profile whose matcher is limited to the Article bundle" execution
# task: delete the eval linkit_profile config entities so the agent starts clean. Neither
# ships by default, so deleting is safe. Idempotent: no-op if already absent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (["eval_articles", "eval_profile"] as $id) {
    if ($p = \Drupal::entityTypeManager()->getStorage("linkit_profile")->load($id)) { $p->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: linkit eval_articles / eval_profile profiles removed"
