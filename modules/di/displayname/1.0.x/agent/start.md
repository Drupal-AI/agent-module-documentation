<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Display Name (displayname) — agent index

Defines a multi-component `display_name` field type (columns: title, first, middle, last, full, alias) with a
component widget, a token-pattern formatter, autocomplete, a Views fulltext filter, a Feeds target, and an optional
override of the core rendered username. Version 1.0.0-alpha2. Core `^8.8 || ^9 || ^10 || ^11`.

- Dependencies: `field`, `user`, `token` (contrib).
- Package: Field types. No admin settings route (`configure` is null); behaviour is set per field/form-display/view-display.

## Provides

- Field type `display_name` (`src/Plugin/Field/FieldType/DisplayNameItem.php`) — 6 varchar(255) columns, indexes on
  first/last/alias/full; computes `full` at `preSave()` when left empty.
- Widget `display_name_default` (`src/Plugin/Field/FieldWidget/DisplayNameWidget.php`) via FAPI element
  `display_name` (`src/Element/DisplayName.php`, expanded in `displayname.module`).
- Formatter `display_name_default` (`src/Plugin/Field/FieldFormatter/DisplayNameFormatter.php`); core `string`
  formatter is also allowed on the field via `hook_field_formatter_info_alter()`.
- Format parser service `displayname.format_parser` (`src/DisplayNameFormatParser.php`) — the token/modifier/
  conditional mini-language and markup modes.
- Views filter `display_name_fulltext` (`src/Plugin/views/filter/Fulltext.php`).
- Feeds target `display_name` (`src/Feeds/Target/DisplayNameTarget.php`).
- Autocomplete route `displayname.autocomplete` → `DisplayNameAutocompleteController` +
  `displayname.autocomplete` / `displayname.options_provider` services.
- Config entities `display_name_format` and `display_name_list_format` (schema only in this alpha; format strings are
  currently resolved from hardcoded maps in `displayname.module`).
- Permission `change own display name` (`displayname.permissions.yml`).
- Config object `displayname.settings` (keys: separators, `component_required_marker`, `user_display_name`).
- Username override via `hook_user_format_name_alter()` + `hook_user_load()` in `displayname.module`.

Note: `displayname.services.yml` also declares `displayname.generator`
(`Drupal\displayname\DisplayNameGenerator`), but that class is not shipped in this alpha; the only caller is
`DisplayNameItem::generateSampleValue()` (sample-content generation).

## Solution docs

- [Field type, widget & storage](fields/field.md)
- [Formatter, format strings & markup](formatters/formatter.md)
- [Settings, username override, Views & Feeds](config/settings.md)
