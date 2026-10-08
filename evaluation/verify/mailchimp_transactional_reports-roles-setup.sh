#!/usr/bin/env bash
# Introspection SETUP: create role mtr_a WITH the 'view mailchimp transactional reports' permission
# and role mtr_b WITHOUT it, so an inspecting agent can tell which role can view reports.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  if (!Role::load("mtr_a")) { Role::create(["id"=>"mtr_a","label"=>"MTR A"])->save(); }
  if (!Role::load("mtr_b")) { Role::create(["id"=>"mtr_b","label"=>"MTR B"])->save(); }
  $a = Role::load("mtr_a"); $a->grantPermission("view mailchimp transactional reports"); $a->save();
  $b = Role::load("mtr_b"); if ($b->hasPermission("view mailchimp transactional reports")) { $b->revokePermission("view mailchimp transactional reports"); $b->save(); }
' >/dev/null 2>&1
echo "setup: role mtr_a has 'view mailchimp transactional reports'; mtr_b does not"
