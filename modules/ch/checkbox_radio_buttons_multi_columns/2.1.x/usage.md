<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a field form-display widget that spreads an options field's checkboxes or radio buttons across multiple columns.

---

Checkbox/Radio button Multi Columns provides a single field widget, `multi_column_options_buttons`, that
extends Drupal core's Options Buttons widget (`OptionsButtonsWidget`) and adds one setting: the number of
columns. When the rendered element is a set of checkboxes, the module's `hook_preprocess_checkboxes()`
applies a `column-count: N` inline CSS style so the options flow into N columns. It is a purely
presentational form-UI feature in the Fields package, depends only on core Options, defines no routes,
permissions, services, or entities, and stores its `columns` value in the normal field form-display config.

---

- Lay out a long checkbox list (e.g. a multi-value list_string field) across two or more columns on an entity edit form.
- Make a list_integer or list_float multi-select field more scannable by wrapping its checkboxes into columns.
- Present entity_reference options as checkboxes arranged in a grid.
- Choose the widget "Check boxes/radio buttons (multi-columns)" in Manage form display for a supported field.
- Set the number of columns per field via the widget settings gear in Manage form display.
- Tidy a boolean field's rendering while keeping core checkbox behavior.
- Replace the stock "Check boxes/radio buttons" widget without changing stored data or field types.
- Keep native Drupal checkbox validation and multiple-value handling while only changing visual layout.
- Reduce vertical scrolling on forms that expose dozens of allowed values.
- Improve editor experience for taxonomy-like option lists rendered as checkboxes.
- Configure a different column count per bundle/form mode using standard form-display config.
- Fall back gracefully to a single column when columns is set to 1.
- Apply the widget across Drupal 9, 10, and 11 sites.
- Use it with any of the supported field types: boolean, entity_reference, list_integer, list_float, list_string.
- Deploy the columns setting through exported configuration like any other form-display component.
- Avoid custom CSS/JS by relying on the browser's native CSS multi-column layout.
- Preview the multi-column arrangement directly on the node/entity add/edit form.
- Standardize option-list layout across multiple content types.
- Enable via Drush (`drush en checkbox_radio_buttons_multi_columns`) then assign the widget.
- Keep the field's allowed_values unchanged while only altering how options are grouped visually.
