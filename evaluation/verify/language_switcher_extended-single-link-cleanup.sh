#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM cleanup for language_switcher_extended: restore the install baseline
# (mode=default, all other keys cleared).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("language_switcher_extended.settings");
  foreach (["untranslated_handler","translation_detection","current_language_mode","hide_single_link","hide_single_link_block","show_langcode"] as $k) { $c->clear($k); }
  $c->set("mode", "default")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: language_switcher_extended.settings restored to baseline (mode=default)"
