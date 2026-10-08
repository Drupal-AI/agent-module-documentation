#!/usr/bin/env bash
# Execution RESET: ensure role ajax_quiz_role exists but does NOT have 'access ajax quiz', so
# verify FAILS until the agent grants it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ajax_quiz_role") ?: Role::create(["id"=>"ajax_quiz_role","label"=>"AJAX Quiz Role"]);
  if ($r->hasPermission("access ajax quiz")) { $r->revokePermission("access ajax quiz"); }
  $r->save();
' >/dev/null 2>&1
echo "reset: role ajax_quiz_role exists without 'access ajax quiz'"
