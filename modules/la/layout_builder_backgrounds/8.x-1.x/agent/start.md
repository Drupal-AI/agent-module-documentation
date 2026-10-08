<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Layout Builder Backgrounds (layout_builder_backgrounds) — agent index

Adds a **per-section background** — a CSS color and/or a media-library image — to **Layout Builder
sections**, applied as **inline styles on the layout wrapper**. Version **8.x-1.1**, branch
`8.x-1.x`. Core `^8.8 || ^9 || ^10 || ^11`. Package "Layout Builder". GPL-2.0-or-later.

Dependencies: core `image`, `media`, `media_library`, plus **`layout_builder_styles`** (the alter
hook expects its `ConfigureSectionForm`) and **`media_library_form_element (>=2.0)`** (supplies the
`media_library` form element). The module ships **no CSS/JS, no config schema, no permission, no
admin route, no Drush command** — its entire surface is two hooks.

## What it actually does (mechanism)

- **`hook_form_layout_builder_configure_section_alter()`** — adds a **Background** details panel to
  the section-configure modal with three fields: **Color** (`textfield`, any CSS color string),
  **Image** (`media_library`, `image` bundle only), **Background position** (`select`, nine
  `left/center/right` × `top/center/bottom` options; default `center center`).
- **`_layout_builder_backgrounds_section_form_submit()`** — a custom submit handler unshifted ahead
  of core's; writes `{color, media, position}` into the section's layout configuration array under
  key **`layout_builder_backgrounds`** (Layout Builder **section settings** in section storage — a
  per-view-mode default layout or a per-entity override). Clearing both color and image **unsets**
  the settings.
- **`hook_preprocess_layout()`** — if the settings exist, adds class **`layout-builder-backgrounds`**
  and builds an inline **`style`** attribute on the layout element:
  - color → `background-color: <color>;` (the CSS color string the editor entered).
  - image → `Media::load($id)` → source file → `File::createFileUrl()` →
    `background-image: url(<file-url>); background-position: <position>; background-size: cover;
    background-repeat: no-repeat;`. Always the **original file** (no image style / responsive image).
- **`hook_help()`** — one paragraph on the module help page. That is all.

## Files

- `agent/sections/backgrounds.md` — full mechanism, storage shape, form/render flow, edge cases.
- `../usage.md` — short/dense/use-cases. `../data.json` — metadata.

## Gotchas

- The image is the **original managed file** — full-bleed hero images are an LCP / page-weight risk;
  there is no image-style integration.
- Fit is hard-coded to `background-size: cover; background-repeat: no-repeat;` — not configurable.
- If a section's background image file is later deleted, `File::load()` can return NULL and the
  preprocess would call `->createFileUrl()` on NULL (PHP error) — a reliability edge case.
- No cache metadata is added for the referenced media entity in preprocess.
- Backgrounds are decorative inline styles: **contrast** and **screen-reader** concerns are entirely
  on the editor; nothing here validates either.
