#!/usr/bin/env bash
# Introspection SETUP: ensure a user with fixed uid 900170 / email ucp_alt@example.com exists.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $s = \Drupal::entityTypeManager()->getStorage("user");
  $ex = $s->loadByProperties(["mail" => "ucp_alt@example.com"]);
  if (!$ex && !User::load(900170)) {
    User::create(["uid" => 900170, "name" => "ucp_alt", "mail" => "ucp_alt@example.com", "status" => 1])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: user ucp_alt@example.com uid=900170"
