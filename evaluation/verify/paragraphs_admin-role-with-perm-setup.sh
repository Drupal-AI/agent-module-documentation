#!/usr/bin/env bash
# Introspection SETUP: create a namespaced role that is granted the paragraphs_admin
# 'administer paragraphs' permission, so an inspecting agent can find which custom role can
# administer paragraphs. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("paragraphs_admin_viewer") ?: Role::create(["id" => "paragraphs_admin_viewer", "label" => "Paragraphs Admin Viewer"]);
  $r->save();
  $r->grantPermission("administer paragraphs")->save();
' >/dev/null 2>&1
echo "setup: role paragraphs_admin_viewer granted 'administer paragraphs'"
