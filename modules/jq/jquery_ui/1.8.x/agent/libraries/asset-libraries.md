<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# jQuery UI asset libraries and the dynamic declaration hook

Goal: understand which libraries `jquery_ui` exposes, how they are wired, and how to depend on them.
Grounded in `jquery_ui.info.yml`, `jquery_ui.libraries.yml`, `jquery_ui.libraries.data.json`,
`jquery_ui.module` and `js/locale.js`. Vendored assets live under `assets/vendor/jquery.ui/`
(jQuery UI **1.13.2**, license "Public Domain", GPL-compatible).

## Install / enable

`drush en jquery_ui -y`. No config, no schema, no install hooks. Enabling it just makes the
libraries available. Widget/effect functionality also needs the relevant companion project enabled
(e.g. `drush en jquery_ui_datepicker`).

## Two sources of library definitions

1. **Static** — `jquery_ui.libraries.yml` declares five keys: `core`, `widget`, `mouse`,
   `position` (all with empty `js: {}` placeholders) and `locale`. Only `locale` carries a real
   asset there: `js/locale.js` with dependencies `core/drupal`, `core/drupalSettings`,
   `core/jquery`.

2. **Dynamic** — `jquery_ui_library_info_alter(array &$libraries, string $module)` in
   `jquery_ui.module` (implements `hook_library_info_alter()`) fills in the real definitions from
   `jquery_ui.libraries.data.json`. On first call it `json_decode()`s that file
   (`JSON_THROW_ON_ERROR`) into a `drupal_static` cache and records the module path. When the hook
   fires for a `$module` that is a top-level key in the JSON, it:
   - defaults each definition's `css`/`js` to `[]`,
   - rewrites every relative asset path to an absolute `/<module-path>/<path>` (via
     `array_combine`/`array_map`), and
   - merges those definitions into `$libraries`.

   So the placeholders `core`/`widget`/`mouse`/`position` get their real JS/CSS + dependency lists
   from the JSON when the hook runs for `$module === 'jquery_ui'`, and every widget/effect library
   is injected when the hook runs for the corresponding companion module machine name.

### Datepicker + locale special-case

At the end of the hook, when `$module === 'jquery_ui_datepicker'`, the `datepicker` library exists,
and core `locale` is enabled, it appends `jquery_ui/locale` to the datepicker's dependencies and
sets `drupalSettings.jquery.ui.datepicker` (`isRTL`, `firstDay`, `langCode = 'drupal-locale'`).
`js/locale.js` (behavior `Drupal.behaviors.jqueryUiDatepickerLocale`) then registers a
`drupal-locale` regional set with `Drupal.t()`-translated month/day names and calls
`$.datepicker.setDefaults(...)` so translated, locale-aware datepickers render.

## Library map (from `jquery_ui.libraries.data.json`)

Top-level keys are Drupal **module machine names**; each holds that module's libraries.

- `jquery_ui` (23 libs): public `core`, `widget`, `mouse`, `position`, plus `internal.*`
  sub-libraries — `internal.data`, `internal.disable-selection`, `internal.focusable`,
  `internal.form`, `internal.form-reset-mixin`, `internal.ie`, `internal.jquery-patch`,
  `internal.jquery-var-for-color`, `internal.keycode`, `internal.labels`, `internal.plugin`,
  `internal.safe-active-element`, `internal.safe-blur`, `internal.scroll-parent`,
  `internal.tabbable`, `internal.unique-id`, `internal.vendor.jquery.color`, `internal.version`,
  `internal.widget-css`. Most `internal.*` libs are single minified files at weight `-11` and
  depend on `core/jquery` + `jquery_ui/internal.version`. `internal.widget-css` supplies the base
  theme CSS (`themes/base/core.css` + `theme.css`).
- `jquery_ui_effects` (16 libs): `core` (the effect engine) plus `blind`, `bounce`, `clip`,
  `drop`, `explode`, `fade`, `fold`, `highlight`, `puff`, `pulsate`, `scale`, `shake`, `size`,
  `slide`, `transfer`.
- One library each for the widget projects: `jquery_ui_accordion` → `accordion`,
  `jquery_ui_autocomplete` → `autocomplete`, `jquery_ui_button` → `button`,
  `jquery_ui_checkboxradio`, `jquery_ui_controlgroup`, `jquery_ui_datepicker` → `datepicker`,
  `jquery_ui_dialog` → `dialog`, `jquery_ui_draggable`, `jquery_ui_droppable`, `jquery_ui_menu`,
  `jquery_ui_progressbar`, `jquery_ui_resizable`, `jquery_ui_selectable`, `jquery_ui_selectmenu`,
  `jquery_ui_slider`, `jquery_ui_sortable`, `jquery_ui_spinner`, `jquery_ui_tabs`,
  `jquery_ui_tooltip`. Each widget declares `core/jquery` + relevant `internal.*` deps (commonly
  `internal.version`, `internal.keycode`, `internal.unique-id`, `jquery_ui/widget`,
  `internal.widget-css`) and a per-widget `themes/base/<widget>.css` component stylesheet.

## Depending on a library

From a render array:

```php
$build['#attached']['library'][] = 'jquery_ui/core';
```

From your module's `*.libraries.yml`:

```yaml
my_module/my_lib:
  dependencies:
    - jquery_ui/core      # was core/jquery.ui
    - jquery_ui/widget    # was core/jquery.ui.widget
    - jquery_ui/position
```

A widget library (e.g. `jquery_ui/datepicker`) resolves only when its companion project
(`jquery_ui_datepicker`) is enabled, because that library is declared on that module's behalf.

## Operating notes

- No settings form / route id → `data.json` `configure` is `null`.
- `hook_help` (`help.page.jquery_ui`) is the only route touched; it renders static About text and
  links to the core deprecation change record (`https://www.drupal.org/node/3067969`) and the
  project page.
- Migration is purely mechanical: swap `core/jquery.ui*` library ids for `jquery_ui/*`. The
  README's guidance is: install, then change references from `core/jquery.ui` to `jquery_ui/core`.
- Asset refresh is a build step (`yarn install && yarn build`; see `scripts/`), not a runtime path.
