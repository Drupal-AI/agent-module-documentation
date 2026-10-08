<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The two plugins and the markup pipeline

The module defines **no plugin types of its own**. It provides one CKEditor 5 plugin and one
filter plugin, both consumed by core.

## 1. CKEditor 5 plugin — `ckeditor_media_resize_mediaResize`

Declared in `ckeditor_media_resize.ckeditor5.yml`, class
`Drupal\ckeditor_media_resize\Plugin\CKEditor5Plugin\MediaResize`
(`extends CKEditor5PluginDefault implements CKEditor5PluginConfigurableInterface`).

```yaml
ckeditor5:
  plugins: [mediaResize.MediaResize]        # JS from js/build/mediaResize.js
  config:
    drupalMedia:
      resizeUnit: 'px'
      resizeOptions:
        - { name: 'resizeMediaImage:original', value: null }
      toolbar: [resizeMediaImage]
      dataAttribute: data-media-width
drupal:
  label: Media image resize
  library: ckeditor_media_resize/editor        # deps: ckeditor5/ckeditor5, ckeditor5/internal.drupal.ckeditor5.media
  elements: ['<drupal-media data-media-width>']
  conditions:
    filter: filter_resize_media
    toolbarItem: drupalMedia
    plugins: [media_media]
```

It merges into core's `drupalMedia` CKEditor config, so the resize handles attach to the
existing media widget rather than adding a new one. `resizeUnit: 'px'` plus the single
`resizeMediaImage:original` option means CKEditor writes a pixel width (or a percentage the
user typed) into `data-media-width`, and "original" clears it.

Configuration methods (see [configure/text-format.md](../configure/text-format.md)):
`defaultConfiguration()` → `['apply_image_styles' => TRUE, 'image_styles' => [4 shipped
styles]]`; `buildConfigurationForm()` exposes only the checkbox;
`validateConfigurationForm()` casts it to bool; `submitConfigurationForm()` stores it.

## 2. Filter plugin — `filter_resize_media`

`Drupal\ckeditor_media_resize\Plugin\Filter\FilterResizeMedia` (annotation-style `@Filter`):

```
id: filter_resize_media
title: "Resize media images"
type: TYPE_TRANSFORM_REVERSIBLE
weight: 90
```

`process($text, $langcode)`:

1. Instantiates the CKEditor plugin `ckeditor_media_resize_mediaResize` via
   `plugin.manager.ckeditor5.plugin` to read its configuration and the
   `ckeditor5.config.drupalMedia.dataAttribute` value (`data-media-width`).
2. `$processing_in_editor = current route === 'media.filter.preview'` — true while CKEditor
   renders its inline preview.
3. `$apply_image_styles = !empty($config['apply_image_styles']) && !$processing_in_editor`.
4. Early-returns unless the raw text contains `data-media-width`.
5. XPath-selects `//*[@data-media-width]` **and** `//figure/drupal-media[@data-media-width]`,
   and calls `processMediaDomNode()` on each.

`processMediaDomNode()`:

- When **not** in the editor preview: reads and **removes** `data-media-width`, then merges
  `width:<value>` into the node's `style` attribute — replacing an existing `width…` segment
  if one is present, otherwise appending `width:<value>;`. It also appends the class
  **`media-embed-resized`** (preserving any existing classes).
- When `apply_image_styles` is on: computes a view mode from the integer width and sets
  `data-view-mode` on the node (only if a match is found).

`getViewModeByWidth(int $width, array $config)`:

```php
$styles = image_style storage->loadMultiple($config['image_styles']);
$widths = for each style: max of $effect['data']['width'] over its effects   // 0 if none
asort($widths, SORT_NUMERIC); array_filter();                                // drop zeros
foreach ($widths as $name => $w) { if ($w >= $width) return $name; }
return '';
```

So the **style name is used as the view-mode name** — which is why the shipped
`config/optional` creates media view modes with exactly the same ids
(`cke_media_resize_small`, …). Requesting 300px picks `cke_media_resize_medium` (500 ≥ 300);
requesting 2000px matches nothing and no `data-view-mode` is set.

`tips()` documents the attribute for the text-format help page.

## Markup in → markup out

Editor output (stored in the field):

```html
<drupal-media data-entity-type="media" data-entity-uuid="…" data-media-width="300"></drupal-media>
```

After `filter_resize_media` (before `media_embed` consumes the tag):

```html
<drupal-media data-entity-type="media" data-entity-uuid="…"
              style="width:300;" class="media-embed-resized"
              data-view-mode="cke_media_resize_medium"></drupal-media>
```

Notes and gotchas:

- The width is written verbatim, so `data-media-width="50%"` yields `style="width:50%;"`
  while `data-media-width="300"` yields `style="width:300;"` (no `px` suffix is added — the
  CKEditor plugin normally emits the unit itself).
- `(int) $width` is used for the view-mode lookup, so `50%` maps as `50`.
- Filter order matters: if `media_embed` runs first the `<drupal-media>` tag is already gone
  and nothing is resized.
- `filter_html` must allow `data-media-width` on `<drupal-media>`; the CKEditor plugin's
  `elements:` declaration adds it automatically when the plugin is enabled.
- Inside CKEditor's own preview (`media.filter.preview`) the attribute is left alone and no
  style/class is applied, so the editor's own resize handles keep working.
- `ckeditor_media_resize_post_update_image_style_config_import()` re-writes every file in
  `config/install` straight into the active `config.storage` — a way to restore the four
  image styles if they were deleted.
