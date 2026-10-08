# Enable PhotoSwipe on a display (Media switch) + PS4/PS5 selection

Blazy PhotoSwipe has **no configure route and no settings form of its own**. You enable it
two ways: per display (choose the lightbox) and, optionally, globally (choose the library
major).

## 1. Per display — choose "Image to PhotoSwipe"

The `photoswipe` lightbox is added to every Blazy-based formatter's **Media switch** select
by `hook_blazy_lightboxes_alter()`. Applies to the `blazy` image formatter, `blazy_media`,
`blazy_oembed`, `blazy_file`, `blazy_entity`, and Slick/Splide/GridStack formatters, plus
Blazy Views fields.

### Via the UI
1. Open a bundle's **Manage display** (e.g. `/admin/structure/types/manage/article/display`).
2. On an image / media field, pick a **Blazy** (or Slick/Splide) formatter and click its cog.
3. Set **Media switch** → **Image to PhotoSwipe**.
4. Set a **Thumbnail style** (initial image) and a **Lightbox image style** (full-res). Save.

### Where it is stored
In the view display config entity
`core.entity_view_display.<entity>.<bundle>.<mode>`, on the field component:

```yaml
content:
  field_gallery:
    type: blazy                 # or blazy_media / slick / splide ...
    settings:
      media_switch: photoswipe  # <-- this is the switch
      # image_style / thumbnail_style / etc.
```

### Via drush php:eval (scriptable)
```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$c = $vd->getComponent('field_gallery');        // a Blazy-capable formatter component
$c['type'] = 'blazy';
$c['settings']['media_switch'] = 'photoswipe';
$vd->setComponent('field_gallery', $c)->save();
```

### Read it back
```bash
drush cget core.entity_view_display.node.article.default content.field_gallery
# look for settings.media_switch: photoswipe
```

## 2. Global — PhotoSwipe 4 vs PhotoSwipe 5

The module adds a **PhotoSwipe** select to **Blazy's** settings form (via
`hook_form_blazy_settings_form_alter()`), not a form of its own. PhotoSwipe 4 is the default.

- UI: `/admin/config/media/blazy` (route `blazy.settings`) → **Extra settings** →
  **PhotoSwipe** → choose *PhotoSwipe 5* (empty option = PhotoSwipe 4). Clear cache.
- Stored as an **integer** in `blazy.settings`:

```yaml
extras:
  photoswipe: 5     # 5 = PhotoSwipe 5; absent or empty = PhotoSwipe 4
```

- Drush:
```bash
drush cset blazy.settings extras.photoswipe 5 -y   # switch to PS5
drush cset blazy.settings extras.photoswipe '' -y  # back to PS4
drush cr
```

`_blazy_photoswipe_is_5()` reads this key; when `5`, the attach uses the `blazy_photoswipe/load5`
library and merges `_blazy_photoswipe_5_options()` defaults. The module also alters Blazy's
config schema so `extras.photoswipe` validates as an integer.

## Library requirement

The PhotoSwipe JS library must exist at `/libraries/photoswipe/dist/…`. For PhotoSwipe 4 the
optional `photoswipe` contrib module supplies library plumbing and a `photoswipe.settings`
options source; for PhotoSwipe 5 the module is not required. Without the library the switch
is selectable but the lightbox will not initialise.
