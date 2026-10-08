<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cosesi — frontend head injection & JS API

## Service `ThemeSettings\Provider`

`src/ThemeSettings/Provider.php` (service id `Drupal\cosesi\ThemeSettings\ProviderInterface`).
Constructor DI: `ThemeManagerInterface`, `ConfigFactoryInterface`, `ExtensionPathResolver`.

- `getSwitcherSettings()` — reads `cosesi.theme_settings` at `themes.<activeThemeId>.switcher`; falls
  back to `getDefaultSwitcherSettings()` when unset.
- `getSwitcherCss($settings)` — returns
  `:root{--<variableName>:light dark;color-scheme:var(--<variableName>);}` plus, when the relevant
  classes are set, `.<lightHtmlClass> .<darkHideClass>,.<darkHtmlClass> .<lightHideClass>{display:none}`
  to hide scheme-specific elements.
- `getSwitcherJavaScript($settings)` — emits a snippet that constructs `new ColorSchemeSwitcher()`,
  assigns `variableName` / `classLight` / `classDark`, calls `init()`, and binds `onDomContentLoaded`.
  Each interpolated value is passed through `json_encode()` before being placed in the JS string.
- `getAttachedHtmlHeadEntries($settings)` — returns two `#attached['html_head']` entries:
  1. `<style id="cosesi-switcher-api-css">` at `#weight -499` with `getSwitcherCss()`.
  2. `<script id="cosesi-switcher-api-js" src="/<modulePath>/libraries/switcher_api/index.js">` at
     `#weight -498`, whose `onLoad` attribute runs the `getSwitcherJavaScript()` snippet (newlines stripped).

These entries are attached by the render elements' `preRenderCosesiApi()` (see plugins doc), so the API
loads on any page rendering a switcher block/element. The `<style>` and `<script src>` are placed early
in `<head>` to initialise `<html>` classes before paint and reduce flicker.

## Client class `ColorSchemeSwitcher`

`libraries/switcher_api/index.js` (library `cosesi/switcher_api`). Options: `storageKey`
(default `colorScheme`), `variableName`, `classLight`, `classDark`.

- `init()` → `updateColorScheme(getSavedColorScheme())`.
- `getSavedColorScheme()` reads `localStorage[storageKey]`; only `light`/`dark` are honoured, anything
  else (incl. missing) is treated as `light dark` (System/Auto).
- `updateColorScheme(value)` resolves `light dark` to the OS preference
  (`matchMedia('(prefers-color-scheme: dark)')`), then:
  - `updateColorSchemeLocalStorage()` — stores `light`/`dark`, or `removeItem` for the default `light dark`.
  - `updateColorSchemeDocument()` — sets `--<variableName>` on `document.documentElement` and toggles
    `classLight`/`classDark` based on the resolved scheme.
- `onDomContentLoaded()` → `initPreferredColorSchemeWatcher()` listens for OS changes and re-applies
  `light dark` when the saved value is System.

Widget behaviour scripts: `libraries/switcher_widget_buttons/index.js` and
`libraries/switcher_widget_dropdown/index.js` (both depend on `core/once`, with `theme.css`) wire the
rendered `button[name="colorScheme"]` clicks to `window.colorSchemeSwitcher`. The button `value` is
`light` / `light dark` / `dark` (from the render element states).

## Theming contract

A frontend theme is expected either to react to the CSS `color-scheme` property on `:root` or to style
against the configured `<html>` classes (default `color-scheme-light` / `color-scheme-dark`). Elements
carrying a per-state `hideClass` (e.g. `color-scheme-only-dark`) are hidden by the injected CSS when the
opposite scheme is active. The switcher block is not rendered on Drupal's minimal batch pages.
