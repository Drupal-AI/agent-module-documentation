<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkbox/Radio button Multi Columns (checkbox_radio_buttons_multi_columns) — agent index

Presentational field form-display widget that lays an options field's checkboxes/radio buttons out across
multiple columns via CSS `column-count`. Package: Fields. Version 2.1.0-alpha1. Core `^9 || ^10 || ^11`.

- **Dependency:** core `options` (`drupal:options`). No composer requirements.
- **Provides:** one FieldWidget plugin `multi_column_options_buttons` (`MultiColumnOptionsButtonsWidget`,
  extends core `OptionsButtonsWidget`); one theme preprocess hook `hook_preprocess_checkboxes()`.
- **Config:** no config object of its own; a `columns` integer lives in each field's form-display component
  settings. Schema: `field.widget.settings.multi_column_options_buttons` (see `config/schema/`).
- **No** routes, permissions, services, entities, drush commands, libraries, or submodules.

Supported field types: boolean, entity_reference, list_integer, list_float, list_string.

Docs:
- [Widget & configuration](fields/widget.md) — the plugin, its `columns` setting, and the preprocess hook.
