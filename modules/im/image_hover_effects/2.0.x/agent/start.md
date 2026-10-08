<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Image Hover Effects (image_hover_effects) — agent index

Provides **two field formatters** that extend core's image formatters with a CSS **hover
effect** plus an optional **overlay caption** on linked images:

- `image_hover_effects_image` — "Image with hover effect" (extends core `ImageFormatter`).
- `image_hover_effects_responsive_image` — "Responsive image with hover effect" (extends
  core `ResponsiveImageFormatter`).

Depends on core `image` **and `responsive_image`**. Package `Sooperthemes` (commercial
theme vendor / DXPR; the module itself is GPL). Version **2.0.2**, core `^8.8 || ^9 || ^10 || ^11`.
No admin page, no permission, no config schema — pure per-display formatter settings.

## Mechanism
- Both formatters `use FormatterTrait`. It adds two settings to the standard image-formatter form:
  - **`hover_effect`** — a select of eight effects: `zoom`, `default` (labelled "Overlay"),
    `fade_in`, `zoom_in`, `fade_in_down`, `fade_in_up`, `fade_in_left`, `fade_in_right`.
  - **`hover_text`** — a textarea rendered as an overlay caption; supports tokens
    (e.g. `[node:title]`). A token-tree browser appears here if the **Token** module is enabled.
- Both settings are hidden via `#states` unless the core **Link image to** (`image_link`)
  setting is set — effects are CSS `:hover` rules on the wrapping `<a>`, so a link is required.
- `viewElements()` calls the parent, then `updateElements()` sets `#theme` to a module template
  and adds `#link_attributes`: class `ihe-overlay ihe-overlay--{effect}` (via `Html::getClass()`)
  and `data-hover` = token-replaced hover text. The library `image_hover_effects/image_hover_effects`
  is attached.
- Templates (`templates/*.html.twig`) wrap the rendered image in `<a{{link_attributes}} href>`.
  `template_preprocess_*` reuse core's image/responsive-image preprocess then cast
  `link_attributes` to an `Attribute` object (values escaped on render).
- CSS (`css/image-hover-effects.css`) does the visuals: `::before` = dark overlay,
  `::after` `content: attr(data-hover)` = the caption (plain text — no markup/line breaks).

## What to raise when this is proposed
1. **Hover does not exist on touch devices.** An effect/caption that *reveals information* rather
   than decorating needs a non-hover path.
2. **Caption is CSS-rendered text.** `content: attr(data-hover)` shows the string literally —
   markup and newlines in Hover text are not honoured (this is also why it is not an XSS vector).
3. **No config schema.** The `hover_effect`/`hover_text` settings have no `*.schema.yml`; expect
   config-schema warnings in strict/test contexts.

## Files
- `usage.md` — human-oriented overview (short / dense / use cases).
- `data.json` — metadata.
