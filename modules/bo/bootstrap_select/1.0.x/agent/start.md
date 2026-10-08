<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap select picker (bootstrap_select) — agent index

A single **Field API widget** that renders option / entity-reference fields with the third-party
**bootstrap-select** jQuery dropdown (searchable, styled, multi-select). Version **1.0.4**. Core
`^8.8.0 || ^9.0 || ^10 || ^11`. License GPL-2.0-or-later. No dependencies on other Drupal modules;
needs **Bootstrap v4** in the active theme.

- **The widget, its five settings, how to enable it per field, asset loading (CDN vs local)** →
  [fields/widget.md](fields/widget.md)

## What it actually is

- One plugin: `BootstrapSelectWidget` (id **`bootstrap_select_widget`**, label *"Bootstrap-Select
  Widget"*) in `src/Plugin/Field/FieldWidget/BootstrapSelectWidget.php`, extending core
  `OptionsWidgetBase`. `field_types = { entity_reference, list_integer, list_float, list_string }`,
  `multiple_values = TRUE`.
- **No routes, no permissions, no services, no Drush, no config schema, no install file.** Assigned
  per field on *Manage form display*; settings live in `core.entity_form_display.*` config.
- Hooks in `bootstrap_select.module`: `hook_help` (renders README, via Markdown module if present),
  `hook_theme` (registers `select__bootstrap_select`, base hook `select`),
  `hook_theme_suggestions_select_alter` (adds that suggestion when `#bootstrap_select` is set),
  `hook_library_info_alter` (swaps the CDN asset for `/libraries/bootstrap-select/...` when a local
  copy exists).

## Mechanism (from source)

- `formElement()` builds a core `#type => 'select'` element, sets `#bootstrap_select => TRUE`, fills
  `#options` from `getOptions()` and `#default_value` from `getSelectedOptions()`, and merges the
  attributes from `getAttributes()`.
- `getAttributes()` maps each setting to a bootstrap-select `data-*` attribute:
  `live_search → data-live-search`, `actions_box → data-actions-box`, `header → data-header`,
  `placeholder → title`, and (only when format is `count`) `data-selected-text-format` +
  `data-count-selected-text`. Every text setting is passed through `Html::escape()` first.
- Template `templates/select--bootstrap-select.html.twig` adds classes `form-control bootstrap-select`,
  attaches libraries `bootstrap_select/package` and `bootstrap_select/init`, and prints options with
  Twig auto-escaping.
- `assets/js/bootstrapSelectInit.js` (`Drupal.behaviors.bootstrapSelectInit`) runs
  `$("select.bootstrap-select", context).selectpicker()`.

## Settings (`defaultSettings()`)

`live_search` (FALSE), `placeholder` (''), `selected_text_format` (`value` | `count`),
`count_selected_text` (`{0} items selected`), `actions_box` (FALSE), `header` (''). Full table,
UI/config paths and asset details in [fields/widget.md](fields/widget.md).

## Assets

- Library `bootstrap_select/package` loads **bootstrap-select 1.13.18** JS+CSS. Default source is the
  **jsDelivr CDN** (`cdn.jsdelivr.net/npm/bootstrap-select@1.13.18`, declared `type: external`).
- `hook_library_info_alter` replaces those URLs with `/libraries/bootstrap-select/dist/...` **iff**
  those local files exist — drop the library into `web/libraries/bootstrap-select` to self-host.
