#!/usr/bin/env bash
# Execution RESET: ensure role dubbot_reviewer exists but WITHOUT any dubbot permissions, so
# verify FAILS until the agent grants report + accessibility-tab access. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("dubbot_reviewer") ?: Role::create(["id" => "dubbot_reviewer", "label" => "DubBot Reviewer"]);
  foreach (["access dubbot report", "view dubbot accessibility tab"] as $p) {
    if ($r->hasPermission($p)) { $r->revokePermission($p); }
  }
  $r->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: role dubbot_reviewer present without dubbot permissions"
