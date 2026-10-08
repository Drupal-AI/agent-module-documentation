#!/usr/bin/env bash
# Introspection CLEANUP: restore the Roles pseudo-field to its baseline (visible `content`
# region, weight 0) on the user form display, undoing the hide done by the matching setup
# script. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $fd->setComponent("roles", ["weight" => 0, "region" => "content"]);
    $fd->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: roles restored to weight 0, content region"
