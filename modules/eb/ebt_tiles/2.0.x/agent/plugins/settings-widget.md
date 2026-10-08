<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `ebt_settings_tiles` widget + EbtTilesHooks

## Field widget `EbtSettingsTilesWidget`

File: `src/Plugin/Field/FieldWidget/EbtSettingsTilesWidget.php`.
Plugin id **`ebt_settings_tiles`**, label "EBT Tiles settings",
`field_types = { "ebt_settings" }`. Extends ebt_core's `EbtSettingsDefaultWidget`, so it
inherits all the shared design controls and adds tile-specific ones in `formElement()`:

- `ebt_settings['styles']` — `radios`, options `one_column` / `two_columns` /
  `three_columns` / `four_columns`, **default `three_columns`**. This value drives the
  column CSS library and the `ebt-tiles-<styles>` class in the block template.
- `ebt_settings['links']` — a `details` group (`#open`) with two checkboxes:
  - `link_in_a_new_tab` (default FALSE)
  - `add_nofollow` (default NULL) — adds `rel="nofollow"` to tile links.

`massageFormValues()` ensures every delta has an `ebt_settings` key (defaults to `[]`)
before save. This widget is assigned to `field_ebt_settings` in the block's default form
display; the block's *view* display instead uses ebt_core's `ebt_settings_default`
formatter.

## Hook class `EbtTilesHooks`

File: `src/Hook/EbtTilesHooks.php`, registered as an autowired service in
`ebt_tiles.services.yml` and dispatched from `ebt_tiles.module` via the `#[LegacyHook]`
shims (`ebt_tiles_theme_registry_alter`, `ebt_tiles_preprocess_paragraph`). Uses the
Drupal 11 `#[Hook(...)]` attribute API.

- **`themeRegistryAlter(&$theme_registry)`** (`hook_theme_registry_alter`) — registers
  `paragraph__ebt_tiles_item__default` pointing at the module's
  `templates/paragraph--ebt-tiles-item--default` template, base hook `paragraph`, reusing
  the base paragraph render element and preprocess chain.

- **`preprocessParagraph(&$variables)`** (`hook_preprocess_paragraph`) — only acts on
  bundle `ebt_tiles_item`. It reads `field_ebt_settings` from the paragraph's **parent
  entity** (the block), and sets two template variables from
  `ebt_settings['ebt_settings']['links']`:
  - `link_in_a_new_tab` ← `links.link_in_a_new_tab` (default FALSE)
  - `nofollow` ← `links.add_nofollow` (default FALSE)

  It returns early if the parent is missing, lacks `field_ebt_settings`, or the field is
  empty. The paragraph template uses these flags to add `target="blank"` / `rel="nofollow"`
  on the clickable-tile anchor.

## Notes

- No config schema ships with this module; the `ebt_settings` field type, its schema and
  the base widget all belong to **ebt_core**. `styles` and the `links.*` values are stored
  inside the ebt_core `field_ebt_settings` value.
