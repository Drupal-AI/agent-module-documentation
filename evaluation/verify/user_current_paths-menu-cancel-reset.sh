#!/usr/bin/env bash
# Execution RESET: delete any account-menu link pointing at internal:/user/current/cancel. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->loadByProperties(["menu_name" => "account"]) as $l) {
    if ($l->get("link")->uri === "internal:/user/current/cancel") { $l->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: removed account-menu links to internal:/user/current/cancel"
