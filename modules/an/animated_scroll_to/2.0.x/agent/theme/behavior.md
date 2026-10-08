# Theme / integration: behaviors, per-element overrides, scroll states

Two Drupal behaviors, one per library. Each reads `drupalSettings.animated_scroll_to.default_settings`
(see [../configure/settings.md](../configure/settings.md)) and both only act when `context === document`.

## `Drupal.behaviors.animatedScrollToInPage` — js/animated-scroll-to-in-page.js

- Runs when the `in_page` library is attached (config `in_page === 1`).
- Selector for links it wires: `a[href^="#"]:not([href="#"]):not([data-toggle])`
  (the `:not([data-toggle])` avoids a Bootstrap `data-toggle` conflict, issue #3036743).
- On `touch`/`click` it `preventDefault()`s the link, resolves the target as `$(link).attr('href')`
  (e.g. `#anchor`), and if that element exists animates `$('html, body')` to
  `targetTop - correction` over `speed` ms with `easing`.
- Delay: only applied when `in_page_links_use_delay` is on; otherwise forced to 0.

## `Drupal.behaviors.animatedScrollToOnPageLoad` — js/animated-scroll-to-on-page-load.js

- Runs when the `on_page_load` library is attached (config `on_page_load === 1`) **and**
  `window.location.hash` is present.
- Supports multiple `#` fragments in the URL, e.g. `example.com/page#first#second#third`.
  It `split('#')`s the hash, drops the empty first item, then scrolls to each existing target
  in sequence, waiting `speed + pause` ms between targets (the first target uses only the start
  `delay`, default 300 ms — "mostly used for image loading").
- Forces the window to the top (`scroll(0,0)`) before starting.

## Per-element `data-scroll-*` overrides

Both scripts read these attributes **from the target element** (the element the hash/href points
at), falling back to the config default when the attribute is absent.

| Attribute | Read by | Overrides | Unit |
|-----------|---------|-----------|------|
| `data-scroll-speed` | both | `default_speed` | ms |
| `data-scroll-correction` | both | `default_correction` | px |
| `data-scroll-easing` | both | `default_easing` | `swing` / `linear` |
| `data-scroll-pause` | on-page-load | `default_pause` | ms |
| `data-scroll-delay` | in-page | `delay` | ms |

Example target markup:

```html
<div id="section-two" data-scroll-speed="1200" data-scroll-correction="80" data-scroll-easing="linear">…</div>
```

## `data-scroll-state` CSS hooks (on-page-load only)

While animating through multi-hash targets, the on-page-load script stamps the target elements
with a `data-scroll-state` attribute you can style/observe:

| State value | Meaning |
|-------------|---------|
| `will-become-active` | set on every hash target up front |
| `is-becoming-active` | the page is currently scrolling toward it |
| `is-active` | scroll finished; it is the current target |
| `was-active` | it was the active target earlier in the sequence |

```css
[data-scroll-state="is-active"] { outline: 2px solid gold; }
```
