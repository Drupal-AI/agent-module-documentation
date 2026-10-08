#!/usr/bin/env bash
# Introspection CLEANUP: restore the account_field_split pseudo-fields mail/name/pass to their
# baseline on the user form display (weight 0, visible `content` region), undoing the known
# order set by the matching setup script. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $fd->setComponent("mail", ["weight" => 0, "region" => "content"]);
    $fd->setComponent("name", ["weight" => 0, "region" => "content"]);
    $fd->setComponent("pass", ["weight" => 0, "region" => "content"]);
    $fd->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: mail/name/pass restored to weight 0, content region"
