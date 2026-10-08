#!/usr/bin/env bash
# Introspection CLEANUP: delete the cpl_role_list price list and cpl_probe_role role. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (\Drupal::entityTypeManager()->getStorage("commerce_pricelist")->loadByProperties(["name"=>"cpl_role_list"]) as $e) { $e->delete(); }
  if ($r = Role::load("cpl_probe_role")) { $r->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: cpl_role_list + cpl_probe_role removed"
