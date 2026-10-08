#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM cleanup: restore full_html to baseline by removing the
# ckeditor_link_styles_linkStyles plugin settings added by setup. Paths relative to
# /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $plugins = $c->get("settings.plugins") ?: [];
  unset($plugins["ckeditor_link_styles_linkStyles"]);
  $c->set("settings.plugins", $plugins);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ckeditor_link_styles settings removed from full_html"
