<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Image sizes presets" formatter (and how the swap works)

## Install & enable

```bash
composer require drupal/image_sizes
drush en image_sizes -y
```

Only dependency is core **`image`**. Provides one permission (`administer image sizes`), a config
entity, one field formatter, one service, two Drush commands. Optional submodule
`image_sizes_defaults` gives you ready-made presets (needs `image_effects`).

## Apply it to a field

Plugin id **`image_sizes_preset_formatter`**, label **"Image sizes presets"**, in
`ImageSizesPresetFormatter` (extends core `FileFormatterBase`, uses `ImageSizesFormatterTrait`).
`field_types = { image, entity_reference }`. `isApplicable()` restricts entity_reference to
`target_type == media` — so it shows for **image fields** and **media-reference fields** only.

UI: *Structure → (bundle) → Manage display* → set the image/media field's format to **Image sizes
presets** → gear icon to pick the preset.

Formatter settings (`defaultSettings()`):

| Setting | Default | Meaning |
|---|---|---|
| `preset` | `FALSE` | **Required.** The `image_sizes_preset_entity` id to render with. Select options come from all presets. |
| `load_invisible` | `FALSE` | When on, adds the `load-always` class so the image loads eagerly instead of waiting for the viewport. |

`settingsSummary()` shows the chosen preset's label. `calculateDependencies()` adds the selected
preset as a config dependency.

Config/Drush equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_image.type image_sizes_preset_formatter -y
drush cset core.entity_view_display.node.article.default \
  content.field_image.settings.preset default -y
drush cr
```

Formatter settings schema: `field.formatter.settings.image_sizes_preset_formatter`
(`config/schema/image_sizes.schema.yml`) — `preset` (string), `load_invisible` (integer). (The
schema also defines a legacy `image_sizes_formatter` mapping; the shipped plugin is the *preset*
one.)

## The preset config entity

`image_sizes_preset_entity` (`ConfigEntityType`, `config_prefix: image_sizes_preset_entity`,
`admin_permission: administer image sizes`). Exported keys: `id, label, uuid, fallback, styles,
preload`. Getters/setters in `ImageSizesPresetEntity`:

- **`styles`** — array of core image-style machine names, the responsive ladder offered to the JS.
- **`preload`** — a single image style used as the low-res placeholder / initial `src`.
- **`fallback`** — an image style machine name **or the literal `original`**; used when no listed
  derivative is wide enough (`getFallBackStyle()` returns the original file URL for `original` or
  when the style fails to load).
- `calculateDependencies()` adds config dependencies on every referenced image style.

Admin routes (via `ImageSizesPresetEntityHtmlRouteProvider` = core `AdminHtmlRouteProvider`):
collection/add/edit/delete under `/admin/config/media/image_sizes_preset_entity`. The add/edit form
(`ImageSizesPresetEntityForm`) offers `preload` (all styles), `styles` (checkboxes of styles whose
effects include a positive-width `ResizeImageEffect` or a `crop_crop`), and `fallback`
(`original` + all styles). All routes require **`administer image sizes`**.

## How the markup is built (server side)

`ImageSizesPresetFormatter::viewValue()` resolves the file, filters the field's `alt`/`title` down
to those two keys, then returns a render array `#theme => 'image_sizes'` with `#style` = the preset,
`#entity` = the File, and `#attributes` = the filtered alt/title (+ `load-always` class if
`load_invisible`).

`template_preprocess_image_sizes()` (`image_sizes.module`) calls
`ImageSizesService::getAttributes($preset, $file, TRUE)` and deep-merges the result, then attaches
library `image_sizes/core`. `ImageSizesService::getAttributes()` produces:

- **`data-src`** — `Json::encode()` of `getStyles()`: for each preset style it loads the image,
  computes the derivative width via `ImageStyle::transformDimensions()` (or reads the
  `ResizeImageEffect` width for invalid/SVG images), and maps `width => ImageStyle::buildUrl($uri)`,
  `ksort`ed.
- **`data-src-fallback`** — `getFallBackStyle()` URL (style URL, or absolute original URL).
- **`class`** — `['image-sizes', 'pre-load']`.
- Placeholder: if inline and `$file->access('view')`, `createBase64Attributes()` builds the preload
  derivative, base64-encodes it into a `data:` URI `src`, and sets `width`/`height`; otherwise
  `src` = the preload style URL.

The template is `templates/image-sizes.html.twig`: **`<img {{ attributes }} />`**. `attributes` is
a core `Drupal\Core\Template\Attribute` object, so every value (including editor-supplied `alt`/
`title`) is auto-escaped by Twig — no `|raw`, no `Markup::create()`. All URLs come from
`ImageStyle::buildUrl()` / the file URL generator, and preset/style config is admin-only.

## How the swap works (client side)

`js/image-sizes.es.js` (behavior `imageSizesBehavior`, library `image_sizes/core`) for each
`img.image-sizes`:

1. A `ResizeObserver` on the parent and (for lazy images) an `IntersectionObserver` fire a
   custom `image:size-check` event.
2. On check it reads `getComputedStyle(parentNode).width`, multiplies by
   `window.devicePixelRatio`, parses `data-src`, and picks the **smallest** derivative key `>=`
   that value; if none, it uses `data-src-fallback`.
3. It swaps that URL into `img.src`, sets `width`/`height` from the loaded image, and toggles the
   `pre-load` / `loading` / `fade-in-on-load` classes (CSS in `css/image-sizes.css`). Loaded URLs
   are cached in `Map`s to avoid refetching.

Lazy by default; the `load-always` class (from `load_invisible`) skips the intersection wait.
