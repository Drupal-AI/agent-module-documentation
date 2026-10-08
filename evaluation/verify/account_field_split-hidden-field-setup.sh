#!/usr/bin/env bash
# Introspection SETUP: disable (hide) the Roles pseudo-field that account_field_split exposes
# on the user form display, so an inspecting agent can discover that "roles" has been moved out
# of the visible `content` region. removeComponent() sends it to the hidden/disabled region.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $fd->removeComponent("roles");
    $fd->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: roles pseudo-field hidden (disabled region) on user form display"
