<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete Field Match (autocomplete_field_match) — agent index

An entity-reference **field widget** whose autocomplete can resolve manually typed input against
**fields other than the entity label**. Depends only on core **`field`** and **`field_ui`**.
No permissions, services, drush, hooks, or admin pages of its own. Core requirement
`^8 || ^9 || ^10 || ^11`. On-disk release **8.x-1.0-alpha6** (a stale D8-era tag still enabled on
D11). License GPL-2.0-or-later.

- **The widget, every setting, the form element, the query mechanism, the route, and how to
  operate it** → [fields/widget.md](fields/widget.md)

## What it actually is (from source)

Three PHP classes, no config entities, no config form:

- **Field widget** `AutocompleteFieldMatchWidget`
  (`src/Plugin/Field/FieldWidget/AutocompleteFieldMatchWidget.php`) — plugin id
  **`autocomplete_field_match`**, `field_types = { "entity_reference" }`, extends core
  `EntityReferenceAutocompleteWidget`. Adds the match settings (`settingsForm()`), summarises them
  (`settingsSummary()`), and emits an `autocomplete_field_match` form element in `formElement()`.
- **Form element** `AutocompleteFieldMatchElement`
  (`src/Element/AutocompleteFieldMatchElement.php`) — `@FormElement("autocomplete_field_match")`,
  extends core `EntityAutocomplete`. Overrides `processEntityAutocomplete()` (wires the module's
  own autocomplete route + a keyvalue-stored, HMAC-keyed selection-settings blob) and
  `validateEntityAutocomplete()`, which is where the non-label field matching runs at submit time.
- **Route controller** `AutocompleteFieldMatchController`
  (`src/Controller/AutocompleteFieldMatchController.php`) — extends core
  `EntityAutocompleteController`; only its `create()` differs (wires extra keyvalue stores). The
  live dropdown is handled by the inherited core `handleAutocomplete()`.

## Routes

- **`autocomplete_field_match.autocomplete`** —
  `/autocomplete_field_match/{target_type}/{selection_handler}/{selection_settings_key}`,
  `_permission: 'access content'`. Read-only typeahead lookup; standard core entity-autocomplete
  behaviour (label matching via the selection handler, which enforces entity access). The
  `selection_settings_key` is an HMAC over the settings signed with the site hash salt.

## Config / schema

- Provides `config/schema/autocomplete_field_match.schema.yml` (`provides_config_schema: true`), a
  near-empty `field.widget.settings.autocomplete_field_match` mapping. Widget settings live in the
  `core.entity_form_display.*` config the widget writes; there is no dedicated settings config
  object and no `configure` route.

## Key facts / caveats

- The extra field-matching is a **validation-time fallback**, not part of the live dropdown: it
  only runs in `validateEntityAutocomplete()` when the editor did NOT pick a dropdown suggestion
  (`extractEntityIdFromAutocompleteInput()` returned NULL). See the mechanism section in
  [fields/widget.md](fields/widget.md).
- The fallback query (`fieldMatchQuery()`) uses `\Drupal::entityQuery(...)->accessCheck(TRUE)` and
  a parameterised `condition()` — access-respecting and not string-concatenated. Input is passed
  through `Xss::filter()` first.
- Only matches one level into a referenced entity (README); the widget explicitly skips nested
  entity-reference fields to avoid recursion.
- Stale-release notes: `AutocompleteFieldMatchController::create()` passes **six** args to core's
  two-arg `EntityAutocompleteController::__construct()` (extras are ignored by PHP); the alpha6 tag
  predates most of D9–D11 but the classes still load and function.
