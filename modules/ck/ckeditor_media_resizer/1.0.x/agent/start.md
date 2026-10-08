<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Media Resizer (ckeditor_media_resizer) — agent index

Lets content editors **resize embedded media images inside CKEditor 5** — by dragging 8-handle
overlays or typing dimensions in a balloon form (units: px, %, em, vw, vh) — and applies the
chosen size to the rendered front-end image. Non-destructive: the media entity is never changed;
size is stored as `data-media-width` / `data-media-height` attributes on the `<drupal-media>` tag.
Package `CKEditor 5`. Core `^10 || ^11`. License GPL-2.0-or-later. Installed version **1.0.3**
(version dir `1.0.x`). Not covered by the security advisory policy; minimally maintained.

This is a **client-side plugin + one text filter** module. There are **no routes, controllers,
services, or permissions**. No server-side image processing happens — the "resize" is purely CSS
dimensions applied to markup.

## Dependencies (from .info.yml)

- Drupal core modules: **`ckeditor5`**, **`media`**, **`image`** (all required).
- No Composer/PHP-library requirements.

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor_media_resizer_mediaResize` (`ckeditor_media_resizer.ckeditor5.yml`):
  - JS plugin `mediaResize.MediaResize` from library `ckeditor_media_resizer/media_resize`
    (`js/media-resize.js`, `css/media-resize.admin.css`; depends on `core/ckeditor5`, `core/drupal`).
  - PHP config class `Plugin/CKEditor5Plugin/MediaResize` — a configurable plugin
    (`CKEditor5PluginConfigurableInterface` + `CKEditor5PluginElementsSubsetInterface`).
    Settings: `enabled` (bool, default TRUE), `min_width` (int px, default 50), `max_width`
    (int px, default 0 = no max). `validateConfigurationForm` rejects `min >= max` when both set.
    `getDynamicPluginConfig` wires the `mediaResize` button into the `drupalMedia` toolbar and
    passes `minWidth`/`maxWidth` to JS; returns `[]` (plugin disabled, adds nothing) when
    `enabled` is FALSE. `getElementsSubset` allows `<drupal-media data-media-width data-media-height>`
    only when enabled.
  - `conditions: { filter: media_embed }` — the plugin is only available on formats that run the
    Embed media filter.
- **Text filter** `media_resize` — `Plugin/Filter/MediaResizeFilter` (title "Apply resize
  dimensions to embedded media"), `TYPE_TRANSFORM_REVERSIBLE`, weight **100**. **Must run AFTER
  the `media_embed` filter.** Reads `data-media-*` attributes on any element and applies inline
  `width`/`max-width:100%`/`height:auto` styles to the inner `<img>` (and to the container element
  for relative units, so `%`/`vw`/`em` resolve against the content column). For px it also sets the
  `width`/`height` HTML attributes; for relative units it deliberately does not (100% would be read
  as 100px). Width takes precedence over height when both present.
- **Config schema** `config/schema/ckeditor_media_resizer.schema.yml` for the plugin settings
  (`provides_config_schema: true`). No permissions, no Drush.
- **Frontend CSS** library `media_resize_frontend` (`css/media-resize.css`) — responsive rules for
  resized images in text-formatted fields. Not auto-attached by a hook; it is the theme's/site's
  responsibility to attach if desired (the filter's inline styles already carry the sizing).
- **hook_help** (`.module`) with About/Installation guidance.
- **hook_uninstall** (`.install`) strips the plugin's settings from every `editor.editor.*` config.
- **Unit test** `tests/src/Unit/MediaResizeFilterTest` covers the filter's dimension parsing.

## Dimension handling (both PHP filter and JS use the same model)

Values are stored WITH a unit (e.g. `300px`, `50%`, `10em`). `MediaResizeFilter::parseDimension()`
allowlists units `[px, %, vw, vh, em]`, casts the numeric part to int (px) / float (others), and
emits `<number><unit>`; unrecognised input falls back to `(int)$value . 'px'`. JS mirrors this with
its own `_parseValue` / `UNITS = ['px','%','em','vw','vh']`. Because the numeric part is cast, the
CSS/attribute output is always a bare number + allowlisted unit (no injection surface — the render
path is safe for author-supplied `data-media-*` values).

## Editor UX (js/media-resize.js — all client-side)

Four internal CKEditor plugins under one `MediaResize` umbrella:
- `MediaResizeEditing` — extends the `drupalMedia` schema with `drupalMediaWidth/Height`, sets up
  upcast/dataDowncast (`data-media-width/height`) and editingDowncast (inline style on the wrapper),
  registers the `mediaResize` command, and keeps editor previews visually correct (a
  MutationObserver strips the PHP filter's inline styles that AJAX preview reloads re-inject, to
  avoid a "double reduction" scaling bug).
- `MediaResizeUI` — toolbar button + balloon `MediaResizeFormView` (unit pills, W/H inputs,
  aspect-ratio lock for px, quick presets 25/50/75/100% and "Original").
- `MediaResizeDrag` — 8-handle drag overlay with a live `W × H` label; clamps to `minWidth`/
  `maxWidth`; corner drags preserve aspect ratio.
- Handles media nested inside container widgets (e.g. advanced columns) via selection fallbacks.

## Setup (summary)

Enable the module, then per text format at `/admin/config/content/formats`: add the **Media
Resizer** button to the CKEditor 5 toolbar (format must use CKEditor 5 + Embed media), and enable
the **Apply resize dimensions to embedded media** filter *after* Embed media. Optionally set
min/max width in the plugin settings. Without the filter, resizing shows in the editor but not on
the published page.

## Security / access

No access-control role: no routes, controllers, or permissions. The only untrusted-input path is
the render filter, which numerically sanitises the `data-media-*` dimension values before emitting
CSS — no server-side fetch, file access, or shell-out is performed.
