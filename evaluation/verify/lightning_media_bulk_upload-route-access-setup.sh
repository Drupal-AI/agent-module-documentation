#!/usr/bin/env bash
# Introspection SETUP: create two roles - lm_bulk_partial with only 'create media' and
# lm_bulk_full with both 'dropzone upload files' and 'create media'. The bulk upload route
# requires BOTH permissions, so only lm_bulk_full can reach it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  if ($r = $storage->load("lm_bulk_partial")) { $r->delete(); }
  $role = $storage->create(["id" => "lm_bulk_partial", "label" => "LM Bulk Partial"]);
  foreach (["create media"] as $p) { $role->grantPermission($p); }
  $role->save();
  $storage = \Drupal::entityTypeManager()->getStorage("user_role");
  if ($r = $storage->load("lm_bulk_full")) { $r->delete(); }
  $role = $storage->create(["id" => "lm_bulk_full", "label" => "LM Bulk Full"]);
  foreach (["dropzone upload files", "create media"] as $p) { $role->grantPermission($p); }
  $role->save();
' >/dev/null 2>&1
echo "setup: roles lm_bulk_partial (create media) and lm_bulk_full (both permissions) created"
