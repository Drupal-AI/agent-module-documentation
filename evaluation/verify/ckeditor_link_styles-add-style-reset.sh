#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD reset: guarantee the `basic_html` CKEditor 5 format exists, has the core Link button
# (the ckeditor_link_styles plugin's condition), and has NO link styles configured yet — so
# verify FAILs on empty state. Ensures the `link` toolbar item is present and clears any
# ckeditor_link_styles_linkStyles settings. The agent must then configure a link style. Paths
# relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $ed = \Drupal::entityTypeManager()->getStorage("editor")->load("basic_html");
  if (!$ed || $ed->getEditor() !== "ckeditor5") {
    print "reset-note: basic_html is not a ckeditor5 editor\n";
  }
  $c = \Drupal::configFactory()->getEditable("editor.editor.basic_html");
  // Ensure the Link button is on the toolbar (plugin condition: ckeditor5_link).
  $items = $c->get("settings.toolbar.items") ?: [];
  if (!in_array("link", $items, TRUE)) { $items[] = "link"; }
  $c->set("settings.toolbar.items", $items);
  // Remove any existing link-styles config so the task starts from empty.
  $plugins = $c->get("settings.plugins") ?: [];
  unset($plugins["ckeditor_link_styles_linkStyles"]);
  $c->set("settings.plugins", $plugins);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: basic_html has Link button and no link styles (link styling absent)"
