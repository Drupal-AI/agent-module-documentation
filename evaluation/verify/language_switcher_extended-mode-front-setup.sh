#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for language_switcher_extended: put the live site into the
# KNOWN "always link to the front page" mode so the agent can read the current mode back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("language_switcher_extended.settings")
    ->set("mode", "always_link_to_front")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mode=always_link_to_front"
