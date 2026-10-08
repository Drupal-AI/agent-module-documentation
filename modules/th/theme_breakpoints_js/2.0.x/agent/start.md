<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Breakpoints for Javascript (theme_breakpoints_js) — agent index

Exposes the **active theme's declared breakpoints** (from `*.breakpoints.yml`) to the browser as
JavaScript. On every HTML page it JSON-encodes the theme's breakpoints into
`drupalSettings.theme_breakpoints` and attaches a small script that turns them into a live
`window.themeBreakpoints` object driven by `window.matchMedia()`. Depends only on core
`breakpoint`. Version **2.0.0**. **Core requirement `^11` — Drupal 11 only** (this 2.0.x branch
dropped D8–D10; use the 1.x branch for older core). No configuration, no permissions, no config
schema, no routes, no admin UI — enable and it works.

## Mechanism (verified against source)

- **`src/Hook/ThemeBreakpointsJsHooks.php`** — `hook_page_attachments()` (attribute-based
  `#[Hook('page_attachments')]`). Calls the service, builds an array of
  `{name, mediaQuery, multipliers}` per breakpoint, then sets
  `$page['#attached']['drupalSettings']['theme_breakpoints'] = Json::encode($breakpoints)` (a JSON
  **string**, not a nested array) and attaches library `theme_breakpoints_js/breakpointsLoader`.
- **`src/ThemeBreakpointsJs.php`** — service id `theme_breakpoints_js` (also autowired by class
  name). `getBreakpointsForActiveTheme()` resolves the active theme via the theme manager;
  `getBreakpoints($theme_name)` returns breakpoints keyed by machine name **with the theme prefix
  stripped** (`preg_replace('/^theme\./', ...)`). **Base-theme fallback:** if the active theme
  defines no breakpoints of its own, it walks `getBaseThemeExtensions()` and uses the first
  ancestor that does. Results are memoized per theme name.
- **`js/breakpointsLoader.js`** (library `breakpointsLoader`, depends on `core/drupalSettings`) —
  parses `drupalSettings.theme_breakpoints` and builds `window.themeBreakpoints`. Registers a
  `matchMedia` listener per breakpoint; on a match change it updates the current breakpoint and
  dispatches the `themeBreakpoint:changed` window event. An empty `mediaQuery` is normalised to
  `(min-width: 0em)`.

## Client-side API (`window.themeBreakpoints`)

- `window.themeBreakpoints.getCurrentBreakpoint()` → the currently matching breakpoint object
  `{name, mediaQuery, multipliers}`, or `false` before/if none match.
- `window.themeBreakpoints.Breakpoints` — the full parsed array of breakpoint objects.
- Event **`themeBreakpoint:changed`** on `window`, fired when the matching breakpoint changes.
  Read the new breakpoint via `window.themeBreakpoints.getCurrentBreakpoint()`. (The event is
  created with the deprecated `document.createEvent('CustomEvent')` for IE compatibility; the new
  breakpoint is passed as the event's custom payload but the reliable read is
  `getCurrentBreakpoint()`.)

```javascript
window.addEventListener('themeBreakpoint:changed', function () {
  var bp = window.themeBreakpoints.getCurrentBreakpoint();
  console.log('Now at breakpoint: ' + (bp ? bp.name : 'none'));
});
```

## Server-side API

Inject the `theme_breakpoints_js` service (or type-hint
`Drupal\theme_breakpoints_js\ThemeBreakpointsJs`) and call `getBreakpointsForActiveTheme()` or
`getBreakpoints($theme_name)` to get `\Drupal\breakpoint\BreakpointInterface[]` with base-theme
resolution handled for you.

## Why it exists

Breakpoints are declared once in the theme and are invisible to JavaScript, so widths get
hard-coded into scripts as magic numbers. When the design changes and the stylesheet's breakpoint
moves but the script's does not, a band of viewport widths appears where CSS says mobile and JS
says desktop — hard to spot because it only shows between two widths nobody tests at. This module
removes the duplication: JS tests the exact media query strings the theme declared, via
`matchMedia` (so `em`-based queries that track font size still work), and reacts to changes through
one event instead of a resize listener.

## Files here

- `agent/api/javascript-api.md` — the client-side and server-side API in detail.
- `usage.md` — plain-language summary and use cases.
- `data.json` — metadata.
