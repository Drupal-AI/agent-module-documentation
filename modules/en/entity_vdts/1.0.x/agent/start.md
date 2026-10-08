<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity View Display Template Suggestions (entity_vdts) — agent index

Adds Twig **template suggestions** to an entity render, toggled **per entity view display** via a
third-party setting on the `entity_view_display` config entity. Package *User interface*. Core
`^11.2 || ^12`. License GPL-2.0-or-later. Version **1.0.2**. No dependencies beyond core (Field UI
must be enabled to see the UI). No routes, permissions, services, or plugins.

- **The full mechanism — UI field, storage, and the two rendering hooks** →
  [theming/template-suggestions.md](theming/template-suggestions.md)

## What it actually is (from source)

- One user-facing feature: a **"bare" template suggestion** checkbox. When enabled on a view
  display, the module appends `ORIGINAL_THEME_HOOK__bare` to the entity's theme suggestions
  (e.g. `node` → `node--bare.html.twig`). The theme must provide that template; the module only
  offers the suggestion.
- Config key / third-party setting namespace: **`entity_vdts`** (constant `CONFIG_KEY` in
  `src/EntityViewDisplayTemplateSuggestionsInterface.php`). Stored key: **`bare`** (boolean).
- OOP hooks only (`services.yml` sets `entity_vdts.skip_procedural_hook_scan: true`):
  - `FormEntityViewDisplayEditFormAlter::alter()` — `#[Hook('form_entity_view_display_edit_form_alter')]`:
    adds the *Template suggestions* details + *bare* checkbox to the view display edit form; an
    `#entity_builders` callback (`entityBuilder()`) saves/unsets the third-party setting.
  - `ThemeSuggestions::entityView()` — `#[Hook('entity_view')]`: copies the display's
    `entity_vdts` third-party settings onto `$build['#entity_vdts']`.
  - `ThemeSuggestions::themeSuggestionsAlter()` — `#[Hook('theme_suggestions_alter')]`: if
    `bare` is set/true, appends `$variables['theme_hook_original'] . '__bare'`.
- Config schema: `config/schema/entity_vdts.schema.yml` defines the `bare` boolean under
  `core.entity_view_display.*.*.*.third_party.entity_vdts`.
- Tests: `tests/src/Functional/TemplateSuggestionsTest.php` verifies the `node--bare` suggestion
  appears only after the third-party setting is enabled.
