#!/usr/bin/env bash
# Reset for the "grant a role the Published on date permission" task. Recreate a clean role
# 'pd_evaluator' that does NOT hold any publication_date permission, so verify FAILs before
# the agent grants it. Deletes and recreates the role for a deterministic starting point.
# Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\user\Entity\Role::load("pd_evaluator")) { $r->delete(); }
  $role = \Drupal\user\Entity\Role::create(["id" => "pd_evaluator", "label" => "PD Evaluator"]);
  $role->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role 'pd_evaluator' recreated with no publication_date permissions"
