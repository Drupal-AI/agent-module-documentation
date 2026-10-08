<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the `colorbox-load` class

There is nothing to configure. You make a link open in a Colorbox lightbox by giving it the
`colorbox-load` class in markup; the module's JS does the rest.

## Minimal usage

```html
<a class="colorbox-load" href="/node/1">View</a>
```

Clicking the link opens `/node/1` inside a Colorbox overlay instead of navigating to it.
This works anywhere the class survives to the browser: a block body, a text-format
(WYSIWYG "source") field, a View's rewritten output, a Twig template, etc.

## Per-link options via the URL query string

Any query parameter on the `href` is parsed and passed to Colorbox as an option, merged over
the site-wide `settings.colorbox` defaults:

```html
<a class="colorbox-load" href="/node/1?width=900&height=700&iframe=true">Open big</a>
```

Mapping rules (from `js/colorbox-simple-load.js`):

| In the URL | Becomes Colorbox option | Notes |
|---|---|---|
| `width=900` | `innerWidth: 900` | `width` is renamed to `innerWidth` |
| `height=700` | `innerHeight: 700` | `height` is renamed to `innerHeight` |
| `true` / `yes` | boolean `true` | e.g. `iframe=true`, `photo=yes` |
| `false` / `no` | boolean `false` | e.g. `open=no` |
| any other `key=value` | `key: value` (string) | passed straight through to Colorbox |

So `?iframe=true` loads the target in an iframe, `?ajax=true` fetches it via AJAX, and so on —
any option Colorbox's jQuery plugin accepts can be set this way.

## How it plugs into Colorbox

- `colorbox_simple_load_page_attachments()` runs on every page: it calls the
  `colorbox.attachment` service (loading Colorbox's library and `drupalSettings.colorbox`)
  and attaches the `colorbox_simple_load/load` library.
- The JS behaviour (`Drupal.behaviors.initColorboxSimpleLoad`) bails out early if
  `$.colorbox` is missing or `settings.colorbox` is undefined, and also if Colorbox's
  `mobiledetect` is on and the screen is narrower than `mobiledevicewidth`.
- It then runs once over each `.colorbox-load` element and calls
  `$(el).colorbox($.extend({}, settings.colorbox, urlParams(el.href)))`.

## What you do NOT set here

Lightbox **style/skin**, default width/height, transition, and mobile behaviour are all
**Colorbox module** settings (`/admin/config/media/colorbox`, config `colorbox.settings`).
This module only adds the per-link `colorbox-load` trigger and the URL-param override; it owns
no configuration of its own.
