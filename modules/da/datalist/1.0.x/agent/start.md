<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datalist (datalist) — agent index

Provides a Drupal render element `'#type' => 'datalist'` (class `Element\Datalist`, extends core
`Textfield`) that renders a text input bound to an HTML5 `<datalist>`: the browser shows the `#options`
as native suggestions while the field still accepts free text. Options are an associative
`key => label` array; by default the **label is shown/typed and the key is submitted** (a
`valueCallback` looks the label up), or set `#use_keys` to expose the key. It also ships an optional
**Webform element** `webform_datalist` (active only when the Webform module is installed — Webform is a
`require-dev`, not a hard dependency).

The element is largely no-JS — the native `<datalist>` needs no script — but the module **does ship
JavaScript/CSS** (library `datalist/datalist`, attached only when `#clear_button` is set) for a "clear"
button, a first-match snap on blur/submit, and a **fallback for mobile browsers that render `<datalist>`
poorly** (mobile Firefox and Edge on Android/iOS): there the JS strips the datalist so a core
`#autocomplete_route_name` autocomplete takes over. Server-side counterparts are provided as helpers
(`DatalistSupportedHelper::isSupportedBrowser()`, `Datalist::fallbackTextfield()`, and the
`datalist_supported` cache context).

- Depends on: nothing outside Drupal core (`dependencies:` is empty). `require-dev`: `drupal/webform ^6`.
- Core: `^9 || ^10 || ^11`. Package: `Other`.
- No settings page / `configure` route, **no routes, no permissions, no config schema, no drush.**
- Defines **no** plugin type; it *implements* one Webform element plugin (`webform_datalist`).
- Provides a render element (`datalist`), a theme hook (`input__datalist`), a JS library
  (`datalist/datalist`), and a cache context (`datalist_supported`).

## What you'd do → where

- **Add a `#type => 'datalist'` field to a form / understand its properties, value handling (key vs
  label), theming, JS and the browser fallback** → [api/render-element.md](api/render-element.md)
- **Add a datalist element to a Webform (`webform_datalist`) / its config fields** →
  [plugins/webform-element.md](plugins/webform-element.md)

## Key facts (real machine names)

- Render element: `datalist` (`Drupal\datalist\Element\Datalist`, `@FormElement("datalist")`, extends
  `Textfield`). Key `#`-props: `#options`, `#use_keys`, `#list`, `#clear_button` (`✖`), `#down_button`
  (`▼`), `#clear_button_description`, `#autocomplete_route_name`, `#autocomplete_route_parameters`.
- Theme hook: `input__datalist` (base hook `input`), template `templates/input--datalist.html.twig`,
  preprocess `datalist_preprocess_input__datalist()`.
- Hooks implemented (`datalist.module`): `hook_help`, `hook_theme`, `hook_preprocess_input__datalist`.
- Library: `datalist/datalist` (`assets/js/datalist.js` + `assets/css/datalist.css`; deps
  `core/drupal`, `core/drupal.announce`, `core/once`). JS behavior id `Drupal.behaviors.datalist`.
- Service / cache context: `cache_context.datalist_supported` (id `datalist_supported`, class
  `Cache\Context\DatalistSupportedCacheContext`). Helper: `Drupal\datalist\DatalistSupportedHelper`.
- Webform element: `webform_datalist` (`Plugin\WebformElement\Datalist`, category "Options elements").
- Static label getters: `Datalist::getClearButton()`, `::getDownButton()`, `::getClearButtonDescription()`.
