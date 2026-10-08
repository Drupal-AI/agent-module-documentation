#!/usr/bin/env bash
# Introspection CLEANUP: delete the mie_importer and mie_exporter roles. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  foreach (["mie_importer","mie_exporter"] as $rid) { if ($r = Role::load($rid)) { $r->delete(); } }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mie_importer, mie_exporter removed"
