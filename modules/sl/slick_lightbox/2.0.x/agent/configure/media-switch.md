# Enable Slick Lightbox on a field / filter

There is **no settings page** for this module (`configure: null`). It works by adding a value
to Blazy's **Media switcher** dropdown.

## On a field formatter (Manage display)

1. Go to *Structure » [entity] » Manage display* (e.g. `/admin/structure/types/manage/article/display`).
2. For an image/media field, choose a Blazy-aware **Format** — e.g. **Blazy** or **Slick carousel**.
3. Open the formatter's settings (the gear icon).
4. Under **Media switcher**, select **Image to Slick Lightbox**.
5. Save.

In config this is stored on the field's component in the view-display entity as
`settings.media_switch: slick_lightbox`, e.g. in
`core.entity_view_display.node.article.default`:

```yaml
content:
  field_image:
    type: blazy            # or a slick_* formatter
    settings:
      media_switch: slick_lightbox
      # ... other Blazy settings ...
```

Set it programmatically:

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
$vd->setComponent('field_image', [
  'type' => 'blazy',
  'region' => 'content',
  'settings' => ['media_switch' => 'slick_lightbox'],
])->save();
```

## Via Blazy Filter (inline images in text)

Enable **Blazy Filter** on a text format (`/admin/config/content/formats/…`) and set its
**Media switcher** to **Image to Slick Lightbox**.

## The Slick optionset that drives the slider

All Slick Lightbox sliders share one Slick optionset config entity:

- Config name: `slick.optionset.slick_lightbox` (id `slick_lightbox`, label "Slick Lightbox").
- Edit UI: `/admin/config/media/slick/list/slick_lightbox/edit` — **requires the `slick_ui`
  sub-module** (`drush en slick_ui -y`), otherwise the route is Access denied.
- Notable shipped keys under `options.settings`: `mobileFirst: true`, `centerMode: true`,
  `lazyLoad: ondemand`, `slidesToShow: 1`, `swipeToSlide: true`; plus responsive breakpoints
  under `options.responsives`. A `skin` key (empty by default → falls back to "default").

Read / change it via Drush:

```bash
drush config:get slick.optionset.slick_lightbox
drush config:set slick.optionset.slick_lightbox options.settings.slidesToShow 2 -y
```

## Front-end library

The JS/CSS lightbox library must exist at
`/libraries/slick-lightbox/dist/slick-lightbox.min.js` (and `.css`) — download from
github.com/mreq/slick-lightbox. `slick_lightbox_requirements()` surfaces an error on the
status report if it is not installed.
