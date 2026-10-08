<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `focal_point_focus` image field formatter

`Drupal\focal_point_focus\Plugin\Field\FieldFormatter\FocalPointFocusFormatter`
(id `focal_point_focus`, label "Focal Point Focus", field type `image`, `quickedit = disabled`).
Extends core image `ImageFormatterBase`; injects `focal_point`'s `FocalPointManager` (built in
`create()` as `new FocalPointManager($container->get('entity_type.manager'))`,
`FocalPointFocusFormatter.php:75-86`).

Select it on **Manage Display** for any `image` field. It has **no admin route and no config schema** —
all settings live on the field-formatter instance.

## Settings (`defaultSettings()` / `settingsForm()`)

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `height` | number (min 2) | `300` | Container display height in px for this view mode. Validated `>= 2` by `validateHeight()` (`:407`). Fallback height when a breakpoint uses `-1`. |
| `first-only` | checkbox | `FALSE` | Render only delta 0 of a multivalue field. |
| `title` | checkbox | `FALSE` | **Mute** the image `title` (when FALSE the title is emitted as `<figcaption>`). |
| `loading` | select | `FALSE`/`''` | `<img loading>` attribute: `''` (none), `lazy`, `eager`. |
| `focal-provider` | select | `'none'` | Core **Breakpoint Group** id to drive responsive heights. Only shown when `breakpoint.manager` service exists. |
| `breakpoint_heights` | nested array | `[]` | Per-provider, per-breakpoint px heights: `breakpoint_heights[provider][breakpoint_id]`. `-1` = use `height`; `0`/empty = mute that breakpoint. |

The breakpoint sub-fields only appear when core **Breakpoint** is enabled; each provider fieldset is
shown/hidden via `#states` keyed on the `focal-provider` select. `settingsSummary()` (`:91-145`)
prints the first-only/mute/height/loading choices and, per breakpoint, the resolved height or "muted".

## Rendering (`viewElements()`, `:271-402`)

For each image item the formatter builds a `#theme => 'focal_point_focus'` element with a `#focalpoint`
properties array. Notable steps:

- **Namespace / CSS class**: `item_namespace = makeFieldName("{field_storage_id}.{bundles}-{viewMode}-{provider}")`
  where `makeFieldName()` = `Html::cleanCssIdentifier(..., ['.' => '--'])` (`:417-419`). Used as the
  `focuspoint-{namespace}` class so per-instance CSS/JS targets the right elements.
- **Source image is the ORIGINAL, un-styled file**: `src` = `file_url_generator->generateAbsoluteString($file->getFileUri())`
  (`:314`). No image style / derivative is applied — this is deliberately *not* an Imagecache module.
- **Focal point → normalised coords** (`:315-330`): reads the crop via
  `$this->focalPointManager->getCropEntity($file, 'focal_point')`. With a crop, `position()` gives pixel
  `x`/`y`, converted to a `-1..1` range:
  - `x = round(($focal_x / $width  - .5) *  2, 4)`
  - `y = round(($focal_y / $height - .5) * -2, 4)`  (Y is inverted for the JS coordinate system)
  These land in `data-focus-x` / `data-focus-y`. **No crop ⇒ `x = y = 0`** (image centred) — safe to add
  the formatter to non-cropped images.
- **Breakpoint CSS** (`:331-394`, only when Breakpoint enabled *and* a crop exists): builds a scoped
  `<style>` string of `.focuspoint-{ns}{height:{default}px}` plus one `@media {mediaQuery}{ .focuspoint-{ns}{height:{h}px} }`
  per configured breakpoint (`-1` → default height; `0`/empty → clause emitted as a `/* muted */`
  comment). The same data is sorted by breakpoint weight and attached as
  `$element['#attached']['drupalSettings']['focalpoint-breakpoints']` for the JS `matchMedia` fallback.

`#focalpoint` keys passed to the template: `loading`, `target_id`, `width`, `height`, `alt`, `title`
(empty when muted), `field_name` (= item_namespace), `focal_provider`, `display_height`, `src`,
`focal_point_x/y`, `x`, `y`, and optional `css`.

## Setup notes (from README)

- The field's **form-display widget** should use the Focal Point *crop thumbnail* preview image style so
  the stored crop matches the reposition math.
- The **manage-display view mode** must have a sensible **Display Height** — it is what the JS uses to
  compute the shift within the available width.
- The wrapper the template renders into should be `display:block` with a real width (e.g. `width:100%`),
  not a bare float, or the width-based math has nothing to measure.
