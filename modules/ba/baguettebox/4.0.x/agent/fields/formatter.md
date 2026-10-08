<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `baguettebox` image field formatter

`Drupal\baguettebox\Plugin\Field\FieldFormatter\BaguetteboxFormatter`
(id `baguettebox`, label "BaguetteBox", field type `image`). **Extends core
`Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`**, so it inherits core's image-style handling,
cache metadata, and entity-to-view resolution, then overrides `defaultSettings()`, `settingsForm()`,
`settingsSummary()` and `viewElements()`.

Select it on **Manage display** for any `image` field (or a media/entity-reference field rendered as an
image). There is **no admin route and no permissions** — every option lives on the formatter instance and
is validated by the config schema `field.formatter.settings.baguettebox`.

## Settings (`defaultSettings()` / `settingsForm()`)

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `image_style` | select (image style) | `''` | Image style for the **thumbnail** rendered on the page (`''` = original). Inherited from core `ImageFormatter`. |
| `baguette_image_style` | select (image style) | `''` | Image style for the **default lightbox** derivative (the `href` / overlay image). `''` = absolute URL of the original file. |
| `baguette_image_style_responsive` | 5 rows of `{width:int, image_style:string}` | 5 empty rows | Responsive lightbox sources. Each row with a `width` emits a `data-at-{width}="{styled url}"` attribute on the `<a>` so baguetteBox.js can swap the overlay source by viewport. Empty `image_style` on a filled `width` → original URL. |
| `selector` | textfield | `.baguettebox` | CSS selector passed to `baguetteBox.run()`. Default matches the `baguettebox` class the formatter puts on the field wrapper. For media-reference fields, set it to the field name/class so all images pool into one gallery. |
| `animation` | select | `slideIn` | Open animation: `none`, `slideIn` ("Slide"), `fadeIn` ("Fade"). |
| `captions_source` | select | `image_alt` | Overlay caption source: `none`, `image_title` (img `title`), `image_alt` (img `alt`). |
| `buttons` | checkbox | `TRUE` | Show prev/next buttons (`'auto'` when TRUE, `false` when FALSE). |
| `fullscreen` | checkbox | `FALSE` | Enable the fullscreen button (`fullScreen`). |
| `hide_scrollbars` | checkbox | `FALSE` | Hide page scrollbars while the gallery is open (`noScrollbars`). |
| `inline` | checkbox | `FALSE` | Adds `container-inline` to the wrapper so thumbnails sit side-by-side. |

`settingsSummary()` prints the thumbnail style, default lightbox style, each configured responsive
`(width → style)`, animation, captions source, selector, and the four booleans (Yes/No via
`getBooleanSettingLabel()`).

## Rendering (`viewElements()`)

For each file resolved by core's `getEntitiesToView()`:

- Builds `#theme => 'baguettebox_formatter'` with:
  - `#item` / `#item_attributes` — the field item, with `_attributes` moved out so the template controls them.
  - `#url` — the lightbox target: `baguette_image_style->buildUrl($uri)` if a default lightbox style is set,
    else `fileUrlGenerator->generateAbsoluteString($uri)` (original).
  - `#link_attributes` — the `data-at-{width}` map built from `baguette_image_style_responsive` (styled URL
    per width, or the default original URL when the row's style is empty).
  - `#image_style` — the thumbnail style.
  - `#cache` — merges the thumbnail image-style cache tags and each file's cache tags; context `url.site`.
- After the loop, on the field wrapper element:
  - `#attached['drupalSettings']['baguettebox'] = $settings` — **the whole settings array**.
  - `#attached['library'][] = 'baguettebox/formatter'`.
  - `#attributes['class'][] = 'baguettebox'` (and `'container-inline'` when `inline`).

**Template** `templates/baguettebox-formatter.html.twig` is a one-liner:
`<a {{ link_attributes }} href="{{ url }}">{{ image }}</a>`. `link_attributes` is wrapped in a Drupal
`Attribute` object (auto-escaped) by the preprocess hook.

**Preprocess** `preprocessBaguetteboxFormatter()` in `src/Hook/BaguetteboxHooks.php` delegates to core's
`ImageThemeHooks::preprocessImageFormatter($variables)` (so `image` gets built exactly like core's image
formatter) and then rebuilds `link_attributes` as an `Attribute`.

## JS behavior (`js/baguettebox.js`)

A `Drupal.behaviors.baguetteBox` attach reads `settings.baguettebox`, builds a `captions` callback (unless
`captions_source === 'none'`) that returns `Drupal.checkPlain(img.title|alt)`, resolves
`selector = settings.baguettebox.selector ?? '.baguettebox'`, and calls:

```js
baguetteBox.run(selector, {
  captions: captions,
  animation: bbSettings.animation,
  buttons: bbSettings.buttons ? 'auto' : false,
  fullScreen: bbSettings.fullscreen,
  noScrollbars: bbSettings.hide_scrollbars
});
```

`css/baguettebox.css` only adds a focus outline on overlay buttons and styles the caption background/size.

## Setup notes

- The external **baguetteBox.js v1.11.1** library is required and NOT bundled: place
  `baguetteBox.min.js` / `baguetteBox.min.css` under `/libraries/baguettebox.js/`.
  `baguettebox_requirements()` (in `baguettebox.install`) raises a runtime **error** when the JS is missing.
- **Single settings bag:** because settings attach to the flat `drupalSettings.baguettebox` key, multiple
  baguettebox displays on one page overwrite each other's settings object — separate galleries must be kept
  apart with distinct `selector` values, and behavior options are effectively per-page, not per-gallery.
- **Views:** enable "Use field template" or add the `baguettebox` class in the field's Views style settings
  so the default `.baguettebox` selector matches the rendered markup.
