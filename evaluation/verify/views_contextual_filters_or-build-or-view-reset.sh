#!/usr/bin/env bash
# Reset the "build an OR contextual-filter view" execution baseline between eval runs so
# each condition is independent: delete the `vcfo_eval_build` view if it exists, leaving
# empty state the agent must build into. No arguments.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal\views\Entity\View::load("vcfo_eval_build")) { $v->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vcfo_eval_build deleted (empty state)"
