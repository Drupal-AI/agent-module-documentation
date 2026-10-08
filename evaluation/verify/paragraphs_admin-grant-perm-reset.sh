#!/usr/bin/env bash
# Execution RESET: ensure a namespaced role paragraphs_admin_editor exists WITHOUT the
# 'administer paragraphs' permission, so verify FAILS until the agent grants it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $r = Role::load("paragraphs_admin_editor") ?: Role::create(["id" => "paragraphs_admin_editor", "label" => "Paragraphs Admin Editor"]);
  $r->save();
  $r->revokePermission("administer paragraphs")->save();
' >/dev/null 2>&1
echo "reset: role paragraphs_admin_editor present WITHOUT 'administer paragraphs'"
