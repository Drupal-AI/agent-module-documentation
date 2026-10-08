<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Responsive Gallery" image formatter

## Install & enable

```bash
composer require drupal/responsive_gallery
drush en responsive_gallery -y
```

Only dependency is core **`field`** (core `image` is required transitively for the base
`ImageFormatter`). No sub-modules, no permissions, no Drush commands, no config objects.

## Enable it on a field

Plugin: `ResponsiveGalleryFormatter`
(`src/Plugin/Field/FieldFormatter/ResponsiveGalleryFormatter.php`, extends core
`Drupal\image\Plugin\Field\FieldFormatter\ImageFormatter`).

- `@FieldFormatter id = "responsive_image"`, label **"Responsive Gallery"**,
  `field_types = {"image"}` — applies to **core image fields only** (not media, not file/link).
- Use a **multi-value** image field to get a real gallery (multiple thumbnails grouped into one
  Fancybox set).

UI path: create/choose an **Image** field (cardinality > 1) on a bundle, then
*Structure → (bundle) → Manage display* → set that field's format to **Responsive Gallery** →
click the gear to set the options below. It also works on an image field placed in a **View**
(the display id is used to group the lightbox).

Drush / config equivalent (view display):

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_gallery.type responsive_image -y
drush cr
```

## Formatter settings

From `defaultSettings()`:

| Setting key | Default | Meaning |
|---|---|---|
| `image_style` | `''` | Image style for the grid thumbnails (empty = original image). |
| `wrapper_class` | `''` | Extra CSS class added to the `rg-grid` container. |
| `extra_large_devices` | `'5'` | Images per row on extra-large screens. Options `5,4,3,2`. |
| `large_devices` | `'4'` | Images per row on large screens. Options `5,4,3,2`. |
| `medium_devices` | `'3'` | Images per row on medium screens. Options `3,2,1`. |
| `small_devices` | `'1'` | Images per row on small screens. Options `2,1`. |

`settingsForm()` renders these (the image-style select carries a "Configure Image Styles" link to
`entity.image_style.collection`). `settingsSummary()` prints the chosen style (or "Original
image"), the wrapper class if set, and the four per-row values on the Manage-display summary line.
There is **no config schema** for these formatter settings (the module ships no `config/`
directory), so strict schema tooling may flag the view-display config — it still saves and works.

### Example view-display config

```yaml
# core.entity_view_display.node.article.default
content:
  field_gallery:
    type: responsive_image
    label: hidden
    settings:
      image_style: large
      wrapper_class: my-gallery
      extra_large_devices: '5'
      large_devices: '4'
      medium_devices: '3'
      small_devices: '1'
```

## How it renders (from `viewElements()`)

1. Builds the four per-breakpoint classes into one string
   `rg-grid-item-elg-{elg} rg-grid-item-lg-{lg} rg-grid-item-md-{md} rg-grid-item-sm-{sm}`
   (`$thumbnail_classes`) and passes it plus `wrapper_class` to the template as `#gallery`.
2. Attaches library `responsive_gallery/responsive_gallery` and sets `#theme => 'responsive_gallery'`.
3. Determines a Fancybox **group** name: inside a View it is `gallery-{display_id}` (from
   `routeMatch->getParameter('view_id')` + the route's `display_id` default); otherwise
   `gallery-{entity bundle}`. (Note: this `$group` is computed but the rendered `data-fancybox`
   attribute is hard-coded to `"gallery"` — see caveats.)
4. Iterates `getEntitiesToView($items, $langcode)` (honors core file access / display flag; early
   returns the empty shell if the field is empty), loads the chosen image style, resolves each
   file URL with `fileUrlGenerator->generateString($image->getFileUri())`, and appends a child:

```php
$elements['#thumbnails']['images'][] = [
  '#theme'      => 'image_formatter',
  '#item'       => $item,
  '#item_attributes' => $item_attributes,
  '#prefix'     => '<div data-fancybox="gallery" data-src="' . $image_uri . '">',
  '#suffix'     => '</div>',
  '#image_style'=> $image_style_setting,
  '#image_uri'  => $image_uri,
  '#cache'      => ['tags' => Cache::mergeTags($thumbnail_cache_tags, $image->getCacheTags())],
];
```

The thumbnail itself is core's `image_formatter` theme, so alt/title text is escaped by core;
`$image_uri` is a core-generated, `UrlHelper::encodePath`-encoded file URL.

## Template

`templates/responsive-gallery.html.twig` (theme hook `responsive_gallery`, registered in
`responsive_gallery_theme()`):

```twig
<div class="rg-grid {{ gallery.wrapper_class }}">
  {% for key,image in thumbnails.images %}
    <div class="rg-grid-item {{ gallery.thumbnail_classes }}">
      {{ image }}
    </div>
  {% endfor %}
</div>
```

Available variables: `gallery.wrapper_class`, `gallery.thumbnail_classes`, `thumbnails.images`.
Copy this template into your theme and adjust markup/classes to change the layout. All values are
printed through Twig auto-escaping.

## Library / front-end

`responsive_gallery.libraries.yml` defines one library, `responsive_gallery/responsive_gallery`,
loading (all **vendored**, no CDN):

- CSS: `css/fancybox.css`, `css/responsive-gallery.css`
- JS: `js/fancybox.js`, `js/imagesloaded.pkgd.min.js`, `js/masonry.pkgd.min.js`, `js/custom.js`
- deps: `core/jquery`, `core/once`, `core/drupal`

`js/custom.js` (`Drupal.behaviors.responsive_gallery`): when `.rg-grid` exists it runs
`imagesLoaded` then `.masonry({ itemSelector: '.rg-grid-item' })`. Fancybox binds the
`data-fancybox="gallery"` thumbnails into a grouped, swipe/pinch-enabled lightbox.

## Caveats

- **Plugin-id collision:** id is `responsive_image`, identical to **core `responsive_image`
  module's** formatter id. If both modules are enabled the definitions clash (whichever is
  discovered last wins) — rename/avoid enabling both, or this formatter may not appear as expected.
- **Fancybox grouping:** the code computes a per-display `$group` (`gallery-{display_id}` or
  `gallery-{bundle}`) but the emitted attribute is the literal `data-fancybox="gallery"`, so every
  gallery on a page joins the **same** lightbox set rather than being grouped by display/bundle.
- `isBackgroundImageDisplay()` checks `getPluginId() == 'responsive_gallery'`; the real id is
  `responsive_image`, so it is always FALSE (dead code inherited from `ImageFormatter`).
- `viewElements()` reads `getSetting('thumbnail_image_style')`, which `defaultSettings()` never
  defines — that thumbnail-cache-tag branch never executes.
- Best results need a **multi-value** image field; a single-value field renders a one-item grid.
