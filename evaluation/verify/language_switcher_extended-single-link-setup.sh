#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM (introspection) setup for language_switcher_extended: KNOWN state where untranslated
# links are hidden AND the switcher collapses to nothing when a single link remains
# (hide_single_link + hide_single_link_block). The agent should read these keys back.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("language_switcher_extended.settings")
    ->set("mode", "process_untranslated")
    ->set("untranslated_handler", "hide_link")
    ->set("hide_single_link", TRUE)
    ->set("hide_single_link_block", TRUE)
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mode=process_untranslated untranslated_handler=hide_link hide_single_link=1 hide_single_link_block=1"
