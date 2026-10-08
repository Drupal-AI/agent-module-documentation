<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field formatters

The module ships three tiny formatters so core field types that had no display formatter can be output
once their base fields are activated. All are standard `#[FieldFormatter]`-attributed plugins in
`src/Plugin/Field/FieldFormatter/`.

## `base_field_display_string` — "Plain text"
- Class `BaseFieldDisplayStringFormatter` extends core
  `Drupal\Core\Field\Plugin\Field\FieldFormatter\StringFormatter` with no overrides.
- `field_types`: `uuid`, `password`. Gives those types a plain-text formatter (core provides none).
- Settings schema inherits `field.formatter.settings.string`.
- Rendering is core `StringFormatter` output; core field access still applies (e.g. the user `pass`
  field's view access is forbidden by core, so it is not output even if activated).

## `base_field_display_path_string` — "String"
- Class `BaseFieldDisplayPathStringFormatter` extends `FormatterBase`.
- `field_types`: `path`. `viewElements()` emits `#markup => $item->getValue()['alias'] ?? ''` for each
  delta — i.e. the raw alias/URL string. (`#markup` is admin-XSS-filtered by the renderer.)
- Empty settings mapping (`field.formatter.settings.base_field_display_path_string`).
- Intended companion for the computed `base_field_display_alias` field (see agent/api/manager.md).

## Usage
1. Activate the base field (e.g. `uuid`, or the computed `Alias`/path field) in the settings form.
2. Go to the entity type's Manage Display for the target view mode.
3. Choose the matching formatter ("Plain text" for uuid, "String" for the path/alias) and save.
