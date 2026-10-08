#!/usr/bin/env bash
# Introspection SETUP: create roles ckpr_yes (with the report permission) and ckpr_no
# (without it). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $y = Role::load("ckpr_yes") ?: Role::create(["id" => "ckpr_yes", "label" => "CKPR Yes"]);
  $y->grantPermission("view ckeditor plugin report")->save();
  $n = Role::load("ckpr_no") ?: Role::create(["id" => "ckpr_no", "label" => "CKPR No"]);
  $n->revokePermission("view ckeditor plugin report")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ckpr_yes has report permission, ckpr_no does not"
