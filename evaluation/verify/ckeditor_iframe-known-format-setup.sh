#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM setup: enable the CKEditor iFrame plugin on the `full_html` text format so exactly
# one format has the Iframe Embed button configured. Appends the `iframeEmbed` toolbar item
# and sets the plugin's enabled_optional_attributes on editor.editor.full_html. The agent
# must inspect live editor config to find which format it is. Idempotent (only appends the
# item if missing). Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $items = $c->get("settings.toolbar.items") ?: [];
  if (!in_array("iframeEmbed", $items, TRUE)) { $items[] = "iframeEmbed"; }
  $c->set("settings.toolbar.items", $items);
  $c->set("settings.plugins.ckeditor_iframe_embed_iframeembed.enabled_optional_attributes",
    ["height", "width", "title", "allowfullscreen"]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Iframe Embed enabled on full_html (iframeEmbed item + enabled_optional_attributes)"
