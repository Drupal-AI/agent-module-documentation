#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD reset: restore the icon set + radius to install defaults (colored square icons, radius 3px)
# so the "flat monochrome + circular" build starts from a state that FAILS verify.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("iconset", "social-icons--square")
    ->set("radius", "3px")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: iconset=social-icons--square radius=3px"
