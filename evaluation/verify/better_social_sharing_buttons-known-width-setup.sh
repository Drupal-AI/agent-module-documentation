#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM setup: write a known icon size + icon set into the live global settings so the
# introspection question ("what is the current width / iconset?") has a discoverable answer.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("width", "44px")
    ->set("iconset", "social-icons--no-color")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: better_social_sharing_buttons.settings width=44px iconset=social-icons--no-color"
