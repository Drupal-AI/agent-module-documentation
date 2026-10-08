#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM cleanup: restore full_html to its standard-profile baseline — remove the
# `iframeEmbed` toolbar item and the ckeditor_iframe_embed_iframeembed plugin settings
# added by setup. Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $items = array_values(array_filter($c->get("settings.toolbar.items") ?: [], function ($i) {
    return $i !== "iframeEmbed";
  }));
  $c->set("settings.toolbar.items", $items);
  $plugins = $c->get("settings.plugins") ?: [];
  unset($plugins["ckeditor_iframe_embed_iframeembed"]);
  $c->set("settings.plugins", $plugins);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: full_html iframeEmbed item + ckeditor_iframe settings removed"
