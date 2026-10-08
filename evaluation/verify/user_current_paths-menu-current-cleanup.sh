#!/usr/bin/env bash
# Execution CLEANUP: delete account-menu links to internal:/user/current. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_link_content");
  foreach ($s->loadByProperties(["menu_name" => "account"]) as $l) {
    if ($l->get("link")->uri === "internal:/user/current") { $l->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed account-menu links to internal:/user/current"
