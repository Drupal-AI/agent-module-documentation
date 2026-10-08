#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# MEDIUM setup: configure a known CKEditor 5 Link Style on the `full_html` text format so
# exactly one format carries a ckeditor_link_styles_linkStyles style. Writes a single
# {label: "Button", element: '<a class="btn">'} entry to
# settings.plugins.ckeditor_link_styles_linkStyles.styles on editor.editor.full_html.
# The agent must inspect live editor config to find which format has it and what its label is.
# Idempotent (overwrites the styles list). Paths relative to /var/www/html.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("editor.editor.full_html");
  $c->set("settings.plugins.ckeditor_link_styles_linkStyles.styles", [
    ["label" => "Button", "element" => "<a class=\"btn\">"],
  ]);
  $c->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Link Style 'Button' (a.btn) configured on full_html"
