#!/usr/bin/env bash
# Introspection SETUP: create role ebp_known_reviewer granted the per-bundle permission
# for node.article, so an agent can discover which role gates that bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("ebp_known_reviewer")) {
    Role::create(["id" => "ebp_known_reviewer", "label" => "EBP Known Reviewer"])->save();
  }
  $r = Role::load("ebp_known_reviewer");
  $r->grantPermission("entity_bundle_permissions access node article")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: role ebp_known_reviewer granted 'entity_bundle_permissions access node article'"
