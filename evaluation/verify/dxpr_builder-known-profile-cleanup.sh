#!/usr/bin/env bash
# Introspection CLEANUP: delete the dxpr_builder_profile created by the matching setup.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\dxpr_builder\Entity\DxprBuilderProfile;
  if ($p = DxprBuilderProfile::load("dxprb_known")) { $p->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: dxpr_builder_profile dxprb_known removed"
