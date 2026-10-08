#!/usr/bin/env bash
# Execution RESET for "put E-mail above Username on the account form". Forces a known WRONG
# baseline so verify FAILS until the agent fixes it: Username (name) is placed FIRST
# (weight -10) and E-mail (mail) LAST (weight 10), both visible in the `content` region.
# The agent must reconfigure the account_field_split pseudo-fields so mail sorts before name.
# Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("user.user.default");
  if ($fd) {
    $fd->setComponent("name", ["weight" => -10, "region" => "content"]);
    $fd->setComponent("mail", ["weight" => 10, "region" => "content"]);
    $fd->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: name(-10) before mail(10) on user form display (mail must be moved above name)"
