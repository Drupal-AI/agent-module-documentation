<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Scrollama — the `data-scroll-*` markup API

Once the `scrollama/scrollama` library is attached, `Drupal.behaviors.scrollama`
(`js/scrollama.js`) scans the DOM for elements with `data-scroll-init` and wires them to a single
scrollama scroller. You control everything from markup and CSS — the module never animates or
changes your HTML itself; it only adds classes.

## Attributes (put on any element)

| Attribute | Required | Meaning |
|---|---|---|
| `data-scroll-init="a b"` | yes | Space-separated class list added when the element **enters** the scroll point. Throws a JS error if missing/empty. |
| `data-scroll-exit="x y"` | no | Class list added when the element **exits** the scroll point. |
| `data-scroll-delay="2"` or `"0.75s"` | no | Delay in **seconds** before the classes are added (accepts a trailing `s`); invalid values throw. |

Example:
```html
<div data-scroll-init="fade-in" data-scroll-exit="fade-out" data-scroll-delay="2">…</div>
```
Enters → after 2s adds `fade-in`; exits → after 2s adds `fade-out`.

## Runtime behavior

- Elements are selected once via `once('scrollama', '[data-scroll-init]', context)`; if none, it
  exits early.
- One `scrollama()` scroller is set up with `offset`, `debug`, `once`, `order` from
  `drupalSettings.scrollama` (see [../configure/settings.md](../configure/settings.md)).
- `onStepEnter`/`onStepExit` add the parsed class lists (after `delay * 1000` ms).
- The scroller re-measures on `window.resize` (debounced 500ms).
- With `debug: true`, the element data (item/init/exit/delay) is printed with `console.table`.

## Shipped animation classes (`scrollama/scrollama-css`)

`css/scrollama.css` gives ready transitions on `[data-scroll-init]` (1s ease-in-out on
opacity/transform):

- `fade-in` → opacity 0 → 1; `fade-out` → 1 → 0.
- `slide-in` → translateY(200px) → 0; `slide-out` → translateY(-200px) → 0.

Use these directly, or ignore the stylesheet and define your own classes matched to your
`data-scroll-init`/`data-scroll-exit` values.

## Known fixed behaviors (no UI/attribute to change them)

- Scroll point is the config `offset` for all elements (per-element offset not supported).
- Enter classes are added, never removed (there is no reset/"leave" removal step).
