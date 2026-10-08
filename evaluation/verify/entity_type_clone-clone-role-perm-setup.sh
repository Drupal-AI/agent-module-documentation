#!/usr/bin/env bash
# Introspection SETUP: create two roles, etc_probe_alpha (no entity_type_clone permission) and
# etc_probe_beta (granted 'access entity type clone'), so the agent must inspect the live site
# to say which role may use the Entity Type Clone forms. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["etc_probe_alpha" => "ETC Probe Alpha", "etc_probe_beta" => "ETC Probe Beta"] as $id => $label) {
    if (!Role::load($id)) { Role::create(["id" => $id, "label" => $label])->save(); }
  }
  $alpha = Role::load("etc_probe_alpha");
  $alpha->revokePermission("access entity type clone");
  $alpha->grantPermission("access content");
  $alpha->save();
  $beta = Role::load("etc_probe_beta");
  $beta->grantPermission("access content");
  $beta->grantPermission("access entity type clone");
  $beta->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: etc_probe_beta has 'access entity type clone'; etc_probe_alpha does not"
