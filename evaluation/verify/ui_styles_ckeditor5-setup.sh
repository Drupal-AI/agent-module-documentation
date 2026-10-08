#!/usr/bin/env bash
# Introspection SETUP (ui_styles_ckeditor5): enable the module and configure the basic_html text
# format so its UI Styles (inline) button offers a known style id (ui_styles_eval_ckstyle), so an
# agent can read enabled_styles back from editor.editor.basic_html. Idempotent.
set -uo pipefail
cd /var/www/html
drush en ui_styles_ckeditor5 -y >/dev/null 2>&1
drush php:eval '
  $config = \Drupal::configFactory()->getEditable("editor.editor.basic_html");
  $items = $config->get("settings.toolbar.items") ?: [];
  if (!\in_array("UiStylesInline", $items, TRUE)) { $items[] = "UiStylesInline"; }
  $config->set("settings.toolbar.items", $items);
  $config->set("settings.plugins.ui_styles_ckeditor5_uiStylesInline.enabled_styles", ["ui_styles_eval_ckstyle"]);
  $config->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: editor.editor.basic_html UiStylesInline button enabled_styles=[ui_styles_eval_ckstyle]"
