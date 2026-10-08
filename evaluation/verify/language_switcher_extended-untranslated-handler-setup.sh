#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for language_switcher_extended: put the live site into a
# KNOWN state so the agent can read it back. Here: process untranslated content entities
# and REPOINT missing-translation links to the front page.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("language_switcher_extended.settings")
    ->set("mode", "process_untranslated")
    ->set("untranslated_handler", "link_to_front")
    ->set("translation_detection", "default")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mode=process_untranslated untranslated_handler=link_to_front"
