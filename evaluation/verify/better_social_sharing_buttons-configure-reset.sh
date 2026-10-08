#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD reset: restore better_social_sharing_buttons.settings to a clean, known baseline (install
# defaults) so the "enable exactly facebook/x/linkedin/whatsapp + width 32px" build starts from a
# state that FAILS verify. Clears the target end-state (whatsapp off, width 20px).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $wanted = ["facebook", "x", "email", "linkedin"];
  $all = ["facebook","x","whatsapp","facebook_messenger","email","pinterest","linkedin",
          "xing","tumblr","reddit","truth","bluesky","evernote","print","copy","telegram"];
  $services = [];
  foreach ($all as $id) { $services[] = ["id" => $id, "enabled" => in_array($id, $wanted, TRUE)]; }
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("services", $services)
    ->set("width", "20px")
    ->set("iconset", "social-icons--square")
    ->set("radius", "3px")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: better_social_sharing_buttons.settings restored to install defaults"
