<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Libraries & the external ElevateZoom Plus JS

Source: `elevatezoom.libraries.yml`, `js/elevate_script.js`, and the `#attached` logic in
`ImageElevateZoomFormatter::viewElements()`.

## The three declared libraries

| Library | Contents | Purpose |
|---|---|---|
| `elevatezoom/elevate_image_zoom_js` | `js/elevate_script.js`; deps `core/drupal`, `core/jquery`, `core/once` | The module's own behaviour (`Drupal.behaviors.elevatezoom`). **Always attached.** |
| `elevatezoom/elevate_image_zoom_cdn` | External, from **jsDelivr**: `jquery.ez-plus.js` (elevatezoom-plus `@1.1.6`) and `jquery.fancybox-plus.js` + `jquery.fancybox-plus.css` (fancybox-plus `@1.3.7`), all `{ type: external }` | The ElevateZoom Plus plugin + Fancybox-Plus lightbox loaded from a CDN. |
| `elevatezoom/elevate_image_zoom_libraries` | `/libraries/elevatezoom/jquery.elevatezoom.js` (local) | Self-hosted ElevateZoom Plus copy (no Fancybox-Plus CSS/JS included here). |

The external plugin the module wires up is **jQuery ElevateZoom Plus**
(`igorlino/elevatezoom-plus`, exposing `$.fn.ezPlus`) together with **Fancybox-Plus**
(`igorlino/fancybox-plus`, exposing `$.fancyboxPlus`) used by the lightbox zoom type.

## CDN vs local

The formatter's **"Use CDN"** checkbox (`cdn` setting, default `TRUE`) is the intended toggle:

- **CDN on** → attach `elevate_image_zoom_cdn` (jsDelivr, versions pinned in `libraries.yml`; no
  local download needed — this is the default).
- **CDN off / self-hosted** → provide the plugin at
  `/libraries/elevatezoom/jquery.elevatezoom.js` and attach `elevate_image_zoom_libraries`.

Download source (per README / `hook_help`): the ElevateZoom Plus library from
`https://github.com/igorlino/elevatezoom-plus`, saved under `/libraries/elevatezoom/`.

> Implementation note: in the current 1.0.6 code, `viewElements()` selects the branch with
> `if ($this->getSetting('elevate_shadow_color'))` rather than the `cdn` setting, and
> `elevate_shadow_color` defaults to a truthy `#000000`, so the **CDN library is attached by
> default**. The self-hosted branch is only taken if the overlay-colour setting is emptied. Treat
> the CDN as the working default; for a fully self-hosted deployment, verify the attached library in
> the page source.

## How it runs

`elevate_script.js` requires `$.fn.ezPlus` (ElevateZoom Plus) and, for the lightbox type,
`$.fancyboxPlus` — both supplied by the CDN (or local) library above. It initialises each
`.elevatezoom` element once, reading the `data-*` attributes the twig template emitted. The CDN
library must load before the behaviour runs; the module relies on library ordering (the behaviour
library is attached first, then the external one) and jsDelivr availability. On air-gapped or
CDN-restricted sites, host the library locally and confirm it is the attached one.
