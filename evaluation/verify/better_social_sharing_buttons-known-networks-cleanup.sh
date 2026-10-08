#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM cleanup: restore the enabled-networks set to the install default (facebook, x, email,
# linkedin enabled; all others disabled). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $wanted = ["facebook", "x", "email", "linkedin"];
  $all = ["facebook","x","whatsapp","facebook_messenger","email","pinterest","linkedin",
          "xing","tumblr","reddit","truth","bluesky","evernote","print","copy","telegram"];
  $services = [];
  foreach ($all as $id) { $services[] = ["id" => $id, "enabled" => in_array($id, $wanted, TRUE)]; }
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("services", $services)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: enabled networks restored to default (facebook, x, email, linkedin)"
