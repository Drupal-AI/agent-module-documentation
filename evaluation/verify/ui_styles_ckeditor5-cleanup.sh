#!/usr/bin/env bash
# Introspection CLEANUP (ui_styles_ckeditor5): remove the UI Styles inline button + its plugin
# settings from basic_html, restoring baseline. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("editor.editor.basic_html");
  $items = $config->get("settings.toolbar.items") ?: [];
  $items = \array_values(\array_filter($items, static fn($i) => $i !== "UiStylesInline"));
  $config->set("settings.toolbar.items", $items);
  $config->clear("settings.plugins.ui_styles_ckeditor5_uiStylesInline");
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: basic_html UI Styles inline button/settings removed"
