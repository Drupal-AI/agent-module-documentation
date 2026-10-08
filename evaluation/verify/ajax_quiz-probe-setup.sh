#!/usr/bin/env bash
# Introspection SETUP: create a role ajax_quiz_role that HAS the 'access ajax quiz' permission,
# so the agent must inspect the live role config to report which permission enables AJAX
# quiz-taking. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("ajax_quiz_role") ?: Role::create(["id"=>"ajax_quiz_role","label"=>"AJAX Quiz Role"]);
  $r->grantPermission("access ajax quiz");
  $r->save();
' >/dev/null 2>&1
echo "setup: role ajax_quiz_role has permission 'access ajax quiz'"
