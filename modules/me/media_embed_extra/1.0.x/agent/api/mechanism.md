<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

The whole module is `media_embed_extra.module` (three hooks) plus one Filter subclass. No
service, config entity, or settings. It is an **enhancement of core Media embedding**, not a
new filter or widget.

## The dialog fields — `hook_form_editor_media_dialog_alter()`

Alters the core `editor_media_dialog` form. It **returns early unless `$form['alt']` is set**,
i.e. only image-source media (which has an alt field) gets the extra UI. It then adds:

```
$form['dimensions']  = ['#type' => 'fieldset', '#title' => 'Dimensions'];
$form['dimensions']['width']  → '#parents' => ['attributes', 'data-width']
$form['dimensions']['height'] → '#parents' => ['attributes', 'data-height']
```

Because the `#parents` point at `attributes.data-width` / `attributes.data-height`, the values
are saved onto the `<drupal-media>` tag as `data-width` and `data-height`. Defaults are read
back from the existing `editor_object` attributes so re-editing shows current values.

## The filter class swap — `hook_filter_info_alter()`

```php
$info['media_embed']['class'] = 'Drupal\media_embed_extra\Plugin\Filter\MediaEmbed';
```

This replaces core's `media_embed` filter implementation with the module's subclass. The
subclass's own `#[Filter(id: "media_embed", …)]` attribute keeps the same id/title/settings as
core, so it is a drop-in replacement — the override only takes effect when the `media_embed`
filter is enabled on the format.

## The render-time override — `MediaEmbed::applyPerEmbedMediaOverrides()`

Extends core's method. After calling `parent::`, if the media has an image source field
(`getMediaImageSourceField()`):

- reads `(int) data-height` and `(int) data-width` from the `<drupal-media>` node;
- if exactly one is given, computes the other from the source image's aspect ratio
  (`width = height * origWidth / origHeight`, or the mirror);
- assigns the resulting `width` / `height` onto the media's image field item.

So the stored media entity is unchanged; only the rendered image dimensions differ per embed.
Media with **no** image source field is left completely alone.

## Consequences an agent should know

- Requires the core `media_embed` filter enabled on the format; if `filter_html` limits tags,
  `data-width`/`data-height` on `<drupal-media>` must be allowed or they are stripped.
- Non-image media never shows the Dimensions fields and is never resized.
- Supplying only one dimension is intentional — the other is derived proportionally.
- No `configure` route, permissions, Drush, or config schema exist for this module.
