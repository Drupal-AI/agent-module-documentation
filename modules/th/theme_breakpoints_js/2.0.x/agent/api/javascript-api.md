<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API reference — theme_breakpoints_js

There is nothing to configure. Enabling the module makes the active theme's breakpoints available
to both JavaScript and PHP. All names below are taken directly from the source.

## Data shape

Each breakpoint is exposed as an object:

```json
{ "name": "wide", "mediaQuery": "all and (min-width: 851px)", "multipliers": ["1x", "2x"] }
```

- `name` — the breakpoint machine name **with the theme/group prefix stripped** (e.g. the
  `olivero.wide` breakpoint becomes `wide`).
- `mediaQuery` — the exact media query string from the theme's `*.breakpoints.yml`. An empty string
  is normalised client-side to `(min-width: 0em)`.
- `multipliers` — the resolution multipliers declared for the breakpoint (e.g. `["1x", "2x"]`).

On the page these arrive as `drupalSettings.theme_breakpoints`, which is a **JSON-encoded string**
(the module calls `Json::encode()` server-side and `JSON.parse()` client-side). If you read
`drupalSettings.theme_breakpoints` yourself, parse it.

## Client-side: `window.themeBreakpoints`

Available after the `theme_breakpoints_js/breakpointsLoader` library runs (attached on every page).
If `drupalSettings.theme_breakpoints` is undefined, `window.themeBreakpoints` is an empty `{}` with
no methods, so guard for it.

| Member | Type | Description |
| --- | --- | --- |
| `getCurrentBreakpoint()` | function → object \| `false` | The breakpoint object currently matching `matchMedia`, or `false` if none match yet. |
| `Breakpoints` | array | All parsed breakpoint objects, in theme-declared order. |
| `currentBreakpoint` | object \| `false` | Backing field for the current breakpoint (prefer the getter). |

### Event: `themeBreakpoint:changed`

Dispatched on `window` whenever the matching breakpoint changes (a `matchMedia` listener is
registered per breakpoint). Read the new value with `getCurrentBreakpoint()`:

```javascript
window.addEventListener('themeBreakpoint:changed', function () {
  var bp = window.themeBreakpoints.getCurrentBreakpoint();
  if (bp && bp.name === 'wide') {
    initDesktopSlider();
  }
});
```

Implementation notes:
- The event is created via the deprecated `document.createEvent('CustomEvent')` /
  `initCustomEvent()` path for legacy IE compatibility. The new breakpoint is passed as the custom
  event payload, but the portable way to read it is `window.themeBreakpoints.getCurrentBreakpoint()`.
- Listeners are attached with `MediaQueryList.addListener()` (the older API, not
  `addEventListener('change', …)`).

### Typical pattern

```javascript
(function () {
  if (typeof window.themeBreakpoints.getCurrentBreakpoint !== 'function') {
    return; // No theme breakpoints on this page.
  }
  function apply() {
    var bp = window.themeBreakpoints.getCurrentBreakpoint();
    document.body.classList.toggle('is-desktop', !!bp && bp.name === 'wide');
  }
  window.addEventListener('themeBreakpoint:changed', apply);
  apply(); // Run once for the initial state.
})();
```

## Server-side: the `theme_breakpoints_js` service

Class `Drupal\theme_breakpoints_js\ThemeBreakpointsJs`, service id `theme_breakpoints_js` (also
resolvable by autowiring the class name).

| Method | Returns | Description |
| --- | --- | --- |
| `getBreakpointsForActiveTheme()` | `\Drupal\breakpoint\BreakpointInterface[]` | Breakpoints for the active theme of the current route, keyed by prefix-stripped machine name. |
| `getBreakpoints(string $theme_name)` | `\Drupal\breakpoint\BreakpointInterface[]` | Breakpoints for a named theme, with the same base-theme fallback and keying. |

Base-theme fallback: if the requested theme declares no breakpoints, the service walks its
`getBaseThemeExtensions()` and returns the first ancestor theme that does. Lookups are memoized per
theme name for the request.

```php
public function __construct(
  private readonly ThemeBreakpointsJs $themeBreakpointsJs,
) {}

public function example(): array {
  $names = [];
  foreach ($this->themeBreakpointsJs->getBreakpointsForActiveTheme() as $name => $breakpoint) {
    $names[$name] = $breakpoint->getMediaQuery();
  }
  return $names;
}
```

## Integration checklist

- Add `theme_breakpoints_js/breakpointsLoader` is attached automatically; your own library only
  needs `core/drupalSettings` if you read the setting directly, or nothing if you use
  `window.themeBreakpoints`.
- Ensure your library loads after the breakpoints loader if it reads `window.themeBreakpoints` at
  parse time; safest is to react to `themeBreakpoint:changed` and also run once on init.
- No breakpoints appear if neither the active theme nor its base themes declare any in a
  `*.breakpoints.yml`.
