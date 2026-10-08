#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD reset: guarantee a CKEditor 5 text format (`basic_html`) exists and does NOT yet have
# the Iframe Embed button, so verify FAILs on empty state. Removes any `iframeEmbed` toolbar
# item and the ckeditor_iframe_embed_iframeembed plugin settings from basic_html. The agent
# must then add the Iframe Embed toolbar item to enable iframe embedding. Paths relative to
# /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("editor");
  $ed = $storage->load("basic_html");
  if (!$ed || $ed->getEditor() !== "ckeditor5") {
    print "reset-note: basic_html is not a ckeditor5 editor\n";
  }
  $c = \Drupal::configFactory()->getEditable("editor.editor.basic_html");
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
echo "reset: basic_html cleared of Iframe Embed button + ckeditor_iframe settings (iframe embedding absent)"
