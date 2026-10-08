<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Checkall Widget (checkall_widget) — agent index

Adds **Check all / Uncheck all** buttons to Drupal's core checkbox (options_buttons) field
widget. Version **1.0.2**. Core `^8 || ^9 || ^10 || ^11`. Package: Field types.
No dependencies outside core (`core/jquery`, `core/drupal`).

## What it provides
- **Field widget plugin** `checkall_widget_options_buttons`
  (`src/Plugin/Field/FieldWidget/CheckallOptionsWidget.php`), extends core
  `OptionsButtonsWidget`. Applies to field types: `boolean`, `entity_reference`,
  `list_integer`, `list_float`, `list_string`; `multiple_values = TRUE`.
- **Asset library** `checkall_widget/checkall_widget` (`js/checkall_widget.js`) — jQuery
  behavior toggling all checkboxes in the widget wrapper.

## What it does NOT provide
No routes, no permissions, no services, no hooks, no admin settings form, no config
schema, no submodules, no Drush commands, no config/install. Stores the same
allowed-option values as the core widget.

## Docs
- [Widget plugin & JS](fields/widget.md) — install, form-display config, how the plugin
  and behavior work, field types.
