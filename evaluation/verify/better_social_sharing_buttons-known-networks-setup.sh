#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM setup: enable a known, non-default set of networks (whatsapp, telegram, bluesky) in the
# live global settings so the introspection question ("which networks are enabled?") is answerable.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $wanted = ["whatsapp", "telegram", "bluesky"];
  $all = ["facebook","x","whatsapp","facebook_messenger","email","pinterest","linkedin",
          "xing","tumblr","reddit","truth","bluesky","evernote","print","copy","telegram"];
  $services = [];
  foreach ($all as $id) { $services[] = ["id" => $id, "enabled" => in_array($id, $wanted, TRUE)]; }
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("services", $services)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: enabled networks = whatsapp, telegram, bluesky"
