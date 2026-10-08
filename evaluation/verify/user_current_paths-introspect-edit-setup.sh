#!/usr/bin/env bash
# Introspection SETUP: ensure a user with fixed uid 900169 / email ucp_known@example.com exists so
# an agent can look up its uid and reason about the user_current_paths redirect. (Site forces
# name=email; we pin the uid.) Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $s = \Drupal::entityTypeManager()->getStorage("user");
  $ex = $s->loadByProperties(["mail" => "ucp_known@example.com"]);
  if (!$ex && !User::load(900169)) {
    User::create(["uid" => 900169, "name" => "ucp_known", "mail" => "ucp_known@example.com", "status" => 1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user ucp_known@example.com uid=900169"
