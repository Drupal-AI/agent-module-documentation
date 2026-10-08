#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) reset for language_switcher_extended: clear config to the install
# baseline (mode=default, other keys removed) so verify FAILs on empty state. The agent
# must then CONFIGURE mode=process_untranslated + untranslated_handler=hide_link.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("language_switcher_extended.settings");
  foreach (["untranslated_handler","translation_detection","current_language_mode","hide_single_link","hide_single_link_block","show_langcode"] as $k) { $c->clear($k); }
  $c->set("mode", "default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: language_switcher_extended.settings cleared to baseline (mode=default)"
