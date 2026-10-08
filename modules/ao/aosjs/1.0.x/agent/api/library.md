# AOS JS — libraries, markup, and PHP helpers

## Asset libraries (`aosjs.libraries.yml`)

| Library | AOS version | Source |
|---|---|---|
| `aosjs/aos-v2.js` | 2.3.4 | local `lib/v2/aos.{css,js}` |
| `aosjs/aos-v2.cdn` | 2.3.4 | cdnjs.cloudflare.com |
| `aosjs/aos-v3.js` | 3.0.0-beta.6 | local `lib/v3/aos.{css,js}` |
| `aosjs/aos-v3.cdn` | 3.0.0-beta.6 | unpkg.com |
| `aosjs/aos.init` | — | `js/aosjs.init.js`, deps: jquery, drupal, drupalSettings, once |

`aos.init` runs `AOS.init()` in a `Drupal.behaviors.aosInit` behavior (no options passed by the base module).

## Auto-attach behavior (`aosjs_page_attachments()`)

- Skips during install.
- Only runs when **neither** `aosjs_ui` **nor** `animatecss_aos` is enabled (those take over attaching).
- Attaches `aos-v2.js` if the library is found locally (`aosjs_check_installed()` checks the file from the `aos-v2.js` library definition), else `aos-v2.cdn`; then always attaches `aos.init`.
- To self-host: place AOS at `libraries/aos` (so the `lib/v2/aos.js` path resolves) — base v2 only checks its own bundled path via the library definition; use `aosjs_ui` for version/method switching.

## Markup usage

Add attributes to any element (block, template, field markup):

```html
<div data-aos="fade-up"
     data-aos-offset="200"
     data-aos-easing="ease-in-sine"
     data-aos-duration="600"
     data-aos-delay="100">…</div>
```

Animation names come in groups: `fade-*`, `flip-*`, `slide-*`, `zoom-*` (see helpers below).

## PHP option helpers (`aosjs.module`)

Used by `aosjs_ui` forms; callable from custom code that needs the same option lists.

- `aosjs_animation_names($animation_name = '')` — grouped animation labels (`fade`, `flip`, `slide`, `zoom`). Runs `hook_aos_animation_names()` (via `invokeAll`, reversed) so other modules can prepend groups.
- `aosjs_animation_options($grouping = TRUE, $names = [])` — flattens the above into a select `#options` array (optionally filtered to given group names / grouped by optgroup).
- `aosjs_easing_functions()` — 20 easing options (`linear`, `ease`, `ease-in-*`, `ease-out-*`, cubic/quart/sine/back variants).
- `aosjs_anchor_placements()` — 9 anchor-placement options (`top-top` … `bottom-bottom`).
- `aosjs_disable_options()` — `false` (none), `phone`, `tablet`, `mobile`.

### Extending animation names

```php
// hook_aos_animation_names($animation_name = '')
function MYMODULE_aos_animation_names($animation_name = '') {
  return ['custom' => ['Custom animations' => ['my-spin' => t('My spin')]]];
}
```
