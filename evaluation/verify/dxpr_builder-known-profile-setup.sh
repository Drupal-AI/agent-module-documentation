#!/usr/bin/env bash
# Introspection SETUP: create a dxpr_builder_profile config entity "dxprb_known" bound to the
# 'authenticated' role with the editor enabled and all elements allowed, so an inspecting agent
# can read back which role(s) it governs. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\dxpr_builder\Entity\DxprBuilderProfile;
  if ($p = DxprBuilderProfile::load("dxprb_known")) { $p->delete(); }
  DxprBuilderProfile::create([
    "id" => "dxprb_known", "label" => "DXPRB Known", "status" => TRUE,
    "dxpr_editor" => TRUE, "weight" => 0,
    "roles" => ["authenticated"], "all_elements" => TRUE,
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: dxpr_builder_profile dxprb_known created for role 'authenticated'"
