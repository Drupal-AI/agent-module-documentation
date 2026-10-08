<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Choices.js Autocomplete (choices_autocomplete) — agent index

Replaces core's select and entity-reference-autocomplete field widgets with ones built on the
bundled **Choices.js** library: a searchable dropdown that shows selections as removable chips.
Also exposes a reusable `choices_autocomplete` render element for custom forms. Widget-only —
field types and stored data are unchanged; switch per form display and switch back freely.

- Dependencies: core only (`^9 || ^10 || ^11`). Choices.js is bundled locally (webpack build in
  `public/js/widget.js`), not loaded from a CDN.
- Configure route: none (`configure: null`). Configured per field on the entity's **Manage form
  display** tab by picking the "Choices.js autocomplete" widget and editing its settings.
- No permissions, no drush commands, no new plugin types. Provides two `@FieldWidget` plugins, one
  `@FormElement`, a theme hook, an invoked alter hook, and config schema.

Docs:
- **Put the Choices.js widget on a field (settings, cardinality, autocreate, config schema)** → [fields/widgets.md](fields/widgets.md)
- **Use the `choices_autocomplete` element in a custom form, alter it, or override its theme/libraries** → [api/element.md](api/element.md)

Key facts:
- Field widget ids: `entity_reference_choices` (field type `entity_reference`),
  `options_select_choices` (field types `list_integer`, `list_float`, `list_string`).
- Form element / theme hook: `choices_autocomplete` (extends core `Select`; base hook `select`;
  template `choices-autocomplete.html.twig`).
- Libraries: `choices_autocomplete/choices`, plus theme add-ons `choices_autocomplete/choices.claro`
  and `choices_autocomplete/choices.olivero` (auto-attached by active theme).
- Invoked alter hook: `hook_choices_autocomplete_element_alter(&$element, &$settings, $form_state)`
  (also a theme-level alter of the same name).
- Defaults service class: `Drupal\choices_autocomplete\ChoicesAutocompleteDefaults::getOptions()`.
- Config schema types: `choices_autocomplete`, `field.widget.settings.options_select_choices`,
  `field.widget.settings.entity_reference_choices`.
- The entity-reference autocomplete search reuses core's `system.entity_autocomplete` endpoint (the
  module adds no route/controller of its own).
