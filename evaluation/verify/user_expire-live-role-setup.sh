#!/usr/bin/env bash
# Introspection SETUP: configure a per-role inactivity expiration (content_editor = 7776000s /
# 90 days) so an inspecting agent can read which role expires and after how long. Baseline is
# an empty user_expire_roles map. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("user_expire.settings");
  $r = $c->get("user_expire_roles") ?: [];
  $r["content_editor"] = 7776000;
  $c->set("user_expire_roles", $r)->save();
' >/dev/null 2>&1
echo "setup: user_expire_roles.content_editor=7776000 (90 days)"
