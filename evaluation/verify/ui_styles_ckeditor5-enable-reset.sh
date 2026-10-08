#!/usr/bin/env bash
# Execution RESET (ui_styles_ckeditor5): ensure basic_html has NO UI Styles inline button/plugin
# settings, so verify FAILS until the agent enables a style. Ensures module enabled. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_ckeditor5 -y >/dev/null 2>&1
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("editor.editor.basic_html");
  $items = $config->get("settings.toolbar.items") ?: [];
  $items = \array_values(\array_filter($items, static fn($i) => $i !== "UiStylesInline"));
  $config->set("settings.toolbar.items", $items);
  $config->clear("settings.plugins.ui_styles_ckeditor5_uiStylesInline");
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: basic_html has no UI Styles inline button/enabled_styles"
