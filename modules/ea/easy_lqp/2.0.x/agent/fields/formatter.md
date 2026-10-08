<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Easy LQP Images" field formatter

`EasyLqpImagesFormatter` (`src/Plugin/Field/FieldFormatter/EasyLqpImagesFormatter.php`), plugin id
**`easy_lqp_images`**, label *"Easy LQP Images"*, `field_types = { "image" }`. It **extends core
`ImageFormatter`**, so it inherits image-link and default-image behaviour but replaces the render
path with the LQP `<picture>`.

## Enable it on an image field

*Structure → (bundle) → Manage display* → set an **Image** field's format to **Easy LQP Images** →
gear icon for the settings below. Config equivalent:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_image.type easy_lqp_images -y
drush cr
```

The formatter removes the core `image_style` select from its settings form (`settingsForm()`
`unset($element['image_style'])`) — style selection is implicit via the generated `responsive_*`
styles.

## Settings (`defaultSettings()`)

| Key | Default | Meaning |
|---|---|---|
| `image_handling` | `scale` | `scale` (scale by width, keep ratio) or `aspect_ratio` (scale + crop to a ratio). The `aspect_ratio` option only appears when at least one aspect ratio has been generated. |
| `aspect_ratio` | `''` | Which generated ratio to use (options from `EasyLqpImagesManager::getAspectRatios()`, keyed `w_h`). Visible only when `image_handling = aspect_ratio`. |
| `multiplier` | `''` | `1x`–`4x`; upscales the chosen derivative for quality (used by the JS as `data-multiplier`). |
| `cover` | `FALSE` | Use container **height** to pick the image (for `object-fit: cover`); emits `data-cover="1"`. |
| `low_quality_placeholder` | `FALSE` | Declared in defaults; the LQP `src` is always produced in `viewElements()`. |

Plus all inherited `ImageFormatter` settings. `settingsSummary()` prints the handling mode (and the
ratio when applicable).

## Render path (`viewElements()`)

1. Calls `parent::viewElements()` then re-points each element's `#theme` to **`easy_lqp_formatter`**.
2. Reads item attributes with a Drupal 10/11.3 (`#item_attributes`) vs 11.4+ (`#attributes`)
   fallback (see drupal.org node 3554585) and wraps them in a core `Attribute` object; sets `alt`,
   `width`, `height`, `data-multiplier`, optional `data-cover`, and class `easy-lqp-image`.
3. Builds `#data` + `#srcset`:
   - **aspect_ratio**: `#srcset = getImagesByAspectRatio($uri, $aspect_ratio)`; sets
     `data-ratio="w:h"` and a temporary width/height (later reset to the original dimensions so the
     tiny LQP is upscaled).
   - **scale**: `#srcset = getImagesByScale($uri)`; computes a temporary height from the original
     aspect ratio (guards against divide-by-zero when dimensions are missing).
4. Sets `#src = getLqp($file, $srcset[0]['url'])` — the inline base64 `data:` URI placeholder.
5. Sets `#cache['contexts'] = ['headers:accept']` (WebP support is sniffed from the Accept header).

## Template `templates/easy-lqp-formatter.html.twig`

Theme hook `easy_lqp_formatter` (`easy_lqp.module` `hook_theme()`), variables `url`, `src`,
`srcset`, `item`, `item_attributes`. It attaches `easy_lqp/resizer`, joins the srcset entries into
`data-srcset`, and renders:

```twig
<picture class="easy-lqp-picture">
  <img
    src="{{ src }}"
    data-srcset="{{ easy_lqp_images_srcset|join(',') }}"
    {{ item_attributes }}
    />
</picture>
```

`src` and `data-srcset` are printed through normal Twig auto-escaping (no `|raw`); `item_attributes`
is a core `Attribute` object.

## Client behaviour — `js/resizer.js`

Library **`easy_lqp/resizer`** (`easy_lqp.libraries.yml`: `js/resizer.js` + `css/easy-lqp.css`;
deps `core/drupal`, `core/once`). `Drupal.behaviors.easyLQP`:

- Uses `once('easy-lqp-image', 'img.easy-lqp-image', context)`; each image is observed by an
  `IntersectionObserver` (`rootMargin: '100px'`) and its parent `<picture>` by a `ResizeObserver`;
  `window.resize` re-runs updates.
- `updateImage()` computes `factor = min(devicePixelRatio, multiplier)`, target width =
  `factor × container width`, picks the **smallest** `data-srcset` entry whose width ≥ target
  (falls back to the largest), preloads it and fades in a new `<source class="easy-lqp-source">`
  before the `<img>`, updating the width/height to the container size.

## Twig `image_url` filter (alternative to the formatter)

For hand-built media view-mode templates you can skip the formatter and use the `image_url` Twig
filter directly — see [../api/manager.md](../api/manager.md). Attach `easy_lqp/resizer` and provide
`src` + `data-srcset` yourself.
