#!/usr/bin/env bash
# Introspection SETUP: create a role storybook_viewer and grant it the 'render storybook
# stories' permission, so an agent can read back which role may hit the render endpoint.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("storybook_viewer")) {
    Role::create(["id"=>"storybook_viewer","label"=>"Storybook Viewer"])->save();
  }
' >/dev/null 2>&1
drush role:perm:add storybook_viewer 'render storybook stories' >/dev/null 2>&1
echo "setup: role storybook_viewer granted 'render storybook stories'"
