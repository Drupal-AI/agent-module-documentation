<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Autocomplete Extras (autocomplete_extras) — agent index

Adds two per-instance settings — **minimum length to trigger autocomplete** and **maximum number of results** — to Drupal core's autocomplete widgets, and applies the same two controls site-wide to the Menu Link Content form. Package `Fields`. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0. **No dependencies** beyond core (`link` module needed only for link-widget support).

- **Widget settings, the menu-link form, config, routes and the JS** →
  [config/settings.md](config/settings.md)

## What it actually is

- A hook-only module. All logic is in one service class `AutocompleteExtrasHooks`
  (`src/Hook/AutocompleteExtrasHooks.php`, autowired via `autocomplete_extras.services.yml`; legacy
  wrappers in `autocomplete_extras.module` are `#[LegacyHook]`). No field type, no plugin, **no
  permission**, no Drush, no new entity route.
- It **alters existing core widgets** — `EntityReferenceAutocompleteWidget` and the `link` module's
  `LinkWidget` — via `hook_field_widget_third_party_settings_form` (adds the settings),
  `hook_field_widget_complete_form_alter` (applies them), and `hook_field_widget_settings_summary_alter`
  (summary). Values are stored as widget **third-party settings** under key `autocomplete_extras`
  (`match_limit`, `min_length`), schema in `config/schema/autocomplete_extras.schema.yml`.
- `hook_form_menu_link_content_menu_link_content_form_alter` applies the same two values to the
  menu-link form's `link` field when enabled in site config.

## Mechanism (from source)

- **match_limit** is pushed into the widget element's `#selection_settings['match_limit']`. Core's
  existing autocomplete route + entity-reference selection handler read this and cap suggestions —
  the module runs **no query of its own** and adds **no endpoint**. For entity-reference widgets the
  value comes from the widget's own core `match_limit` setting; for link widgets it comes from the
  third-party `match_limit`.
- **min_length** is written to `#attributes['data-min-length']` and enforced **client-side** by
  `js/autocomplete_extras.js` (`Drupal.behaviors.autocompleteExtras`), which calls jQuery UI
  `.autocomplete('option', 'minLength', …)`. Library `autocomplete_extras/autocomplete_extras`
  (deps `core/drupal.autocomplete`, `core/once`). Purely a UX gate, not a security control.

## Config & route

- Config object **`autocomplete_extras.settings`** — only the `menu_link_content` mapping
  (`enabled`, `match_limit`, `min_length`). Edited at
  **`/admin/config/user-interface/autocomplete-extras`** (route `autocomplete_extras.settings`,
  form `AutocompleteExtrasSettingsForm`, permission **`administer site configuration`**, menu link
  under *Configuration → User interface*).
- Defaults: `DEFAULT_MATCH_LIMIT = 10`, `DEFAULT_MIN_LENGTH = 1`.
