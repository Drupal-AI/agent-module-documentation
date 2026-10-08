#!/usr/bin/env bash
# Introspection SETUP: create two roles, mie_importer (granted 'metatag import export csv
# upload') and mie_exporter (granted 'metatag import export csv download'), so the agent can
# read back which role holds which metatag_import_export_csv permission. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $defs = [
    "mie_importer" => "metatag import export csv upload",
    "mie_exporter" => "metatag import export csv download",
  ];
  foreach ($defs as $rid => $perm) {
    $r = Role::load($rid) ?: Role::create(["id" => $rid, "label" => strtoupper($rid)]);
    $r->grantPermission($perm);
    $r->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mie_importer(upload), mie_exporter(download)"
