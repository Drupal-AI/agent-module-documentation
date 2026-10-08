<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Existing Values Autocomplete Widget (existing_values_autocomplete_widget) — agent index

Provides a field widget for `string` text fields that autocompletes from values already
stored in that same field elsewhere on the site (a lightweight alternative to taxonomy
references or "allowed values"). The widget extends core `StringTextfieldWidget` and wires
each field element to a JSON autocomplete route backed by one controller.

- Dependencies: core `field` and `text`. Core requirement `^10.1 || ^11`. No external
  composer requirements.
- No module settings page (`configure` is null). Configuration is per field, on each
  bundle's **Manage Form Display** page: pick the "Autocomplete: existing values" widget.
- Defines no permissions and no drush commands. Provides one field widget plugin and one
  route/controller. Ships config schema for the widget settings.

Solutions:
- **Turn a text field into an existing-values autocomplete** → [fields/widget.md](fields/widget.md)
- **How the autocomplete endpoint works (route, params, query, filtering)** → [api/autocomplete-route.md](api/autocomplete-route.md)
- **Map D7 CCK autocomplete widgets to this widget during migration** → [hooks/migration.md](hooks/migration.md)

Key facts (real machine names):
- Widget plugin id: `existing_autocomplete_field_widget`, label "Autocomplete: existing values",
  `field_types = {"string"}`, class `Drupal\existing_values_autocomplete_widget\Plugin\Field\FieldWidget\ExistingAutocompleteFieldWidget`.
- Widget setting: `suggestions_count` (integer, default `15`, `#min` 1, required).
- Config schema key: `field.widget.settings.existing_autocomplete_field_widget`
  (extends `field.widget.settings.string_textfield`).
- Route: `existing_values_autocomplete_widget.autocomplete`, path
  `/existing-values/autocomplete/{entity_type_id}/{bundle}/{field_name}`, `_format: json`,
  `_permission: 'access content'`; each param constrained by `[a-z_]+`.
- Controller: `AutocompleteController::handleAutocomplete($request, $entity_type_id, $bundle, $field_name)`.
- Services injected: `entity_type.manager`, `database`, `entity_field.manager`, `entity_display.repository`.
- Hooks implemented: `hook_help`, `hook_field_migration_field_widget_info`.
- Matching is case-insensitive; suggestions are limited to values on entities/fields the
  current user may view, and capped at `suggestions_count`.
