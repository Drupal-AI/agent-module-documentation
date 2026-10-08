<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CSS Toggle Switch (css_toggle_switch) — agent index

A reusable, accessible **CSS-only** switch **Form API element** built on core's `Radios`, plus a
Better Exposed Filters widget and an optional Webform submodule. Package `Field`. Core requirement
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.7. **No routes, no permissions, no
services, no config objects, no Drush.** Base module has **no Drupal module dependencies**;
`better_exposed_filters` and `webform` are only *suggested*.

- **The `toggle_switch` render element, its properties, theming and asset loading** →
  [elements/toggle-switch.md](elements/toggle-switch.md)
- **The Better Exposed Filters widget for Views exposed filters** →
  [integrations/better-exposed-filters.md](integrations/better-exposed-filters.md)
- **The optional Webform submodule (`toggle_switch` + `toggle_switch_entity` elements)** →
  [../modules/css_toggle_switch_webform/1.0.x/agent/start.md](../../modules/css_toggle_switch_webform/1.0.x/agent/start.md)

## What it actually is

- **Two Form API render elements** (`src/Element/`):
  - `ToggleSwitch` (`@FormElement("toggle_switch")`) extends core `Radios`. Adds a
    `processToggleSwitch` process, drops the fieldset pre-render, and sets theme wrapper
    `toggle_switch`.
  - `ToggleSwitchOption` (`@FormElement("toggle_switch_option")`) extends core `Radio`, theme
    wrapper `toggle_switch_option`.
- **One BEF filter widget plugin**: `Plugin/better_exposed_filters/filter/CssToggleSwitch`
  (`@BetterExposedFiltersFilterWidget id="css_toggle_switch"`) — only active when
  `better_exposed_filters` is installed.
- **Theme + templates**: `hook_theme()` registers `toggle_switch` and `toggle_switch_option`;
  `templates/toggle-switch.html.twig` and `toggle-switch-option.html.twig` with preprocess
  functions in `css_toggle_switch.module`.
- **Libraries** (`css_toggle_switch.libraries.yml`): `element.toggle_switch` (module CSS/JS) which
  depends on the external `css_toggle_switch` CSS (ghinda/css-toggle-switch 4.1.0, jsDelivr CDN)
  and `detect_swipe` (2.1.4, jsDelivr CDN). `hook_library_info_alter` swaps the CDN URLs for local
  copies if the assets are found under the site `libraries/` dir (via
  `library.libraries_directory_file_finder`).
- **Submodule** `css_toggle_switch_webform` (in `modules/`): adds Webform elements; depends on
  `webform:webform`.

## Mechanism (from source)

- `ToggleSwitch::getInfo()` appends `processToggleSwitch` to `#process`, sets `#pre_render = []`
  (removes the CompositeFormElement fieldset), and `#theme_wrappers = ['toggle_switch']`.
- `ToggleSwitch::processToggleSwitch()` retypes every `#options` child to
  `#type = 'toggle_switch_option'`, unsets per-option `#attributes`, and attaches library
  `css_toggle_switch/element.toggle_switch`.
- `ToggleSwitch::valueCallback()` mirrors core Radios but forces a default: when there is no input
  and no `#default_value`, it selects the first option key.
- `css_toggle_switch_preprocess_toggle_switch()` runs `template_preprocess_radios()`, then adds the
  `#toggle_type` (default `switch-toggle`) class to the wrapper, merges `#wrapper_attributes` and
  `#attributes['class']`, and turns `#toggle_on__attributes` into an `Attribute` object rendered as
  `<a{{ toggle_on__attributes }}>` in the wrapper template.
- `css_toggle_switch_preprocess_toggle_switch_option()` calls `template_preprocess_form_element()`
  and sets an empty `onclick=''` label attribute (documented workaround for older iOS / Opera Mini
  tap handling).

## Notes / caveats

- Purely presentational Form API element — it does not add routes, access checks, storage, or
  request-handled endpoints. The classes/attributes it injects come from element definitions and
  (for BEF/Webform) admin-configured widget settings, not from end-user request input.
- Default assets load from a public CDN (`//cdn.jsdelivr.net/...`); for offline/CSP-strict sites,
  drop `css-toggle-switch` and `detect_swipe` into `libraries/` so `hook_library_info_alter` serves
  them locally (see [elements/toggle-switch.md](elements/toggle-switch.md)).
