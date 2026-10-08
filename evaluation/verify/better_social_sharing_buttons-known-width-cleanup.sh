#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM cleanup: restore icon size + icon set to their install defaults. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("better_social_sharing_buttons.settings")
    ->set("width", "20px")
    ->set("iconset", "social-icons--square")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: better_social_sharing_buttons.settings width=20px iconset=social-icons--square"
