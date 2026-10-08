#!/usr/bin/env bash
# Introspection SETUP: arrange the account_field_split pseudo-fields on the user form display
# into a KNOWN order so an inspecting agent can read it back: E-mail (mail) first, then
# Username (name), then Password (pass). Distinctive negative weights make the order
# unambiguous. All three remain in the visible `content` region. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $fd->setComponent("mail", ["weight" => -5, "region" => "content"]);
    $fd->setComponent("name", ["weight" => -4, "region" => "content"]);
    $fd->setComponent("pass", ["weight" => -3, "region" => "content"]);
    $fd->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user form display order mail(-5) < name(-4) < pass(-3)"
