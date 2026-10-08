# Configure the Slideshow formatter

No global settings page (`configure` null). On an entity's **Manage display**
(`admin/structure/…/display`), set an **Image** field's format to **Slideshow** and open the cog. The
formatter (`FieldSlideshow`, extends core `ImageFormatter`) inherits the standard image-formatter
options (image style, image link) and adds the groups below. Settings persist in the
`entity_view_display` config entity.

## Where settings are stored

```
core.entity_view_display.<entity>.<bundle>.<view_mode>:
  content:
    <field_name>:
      type: slideshow
      settings:
        slideshow: { …Cycle2 options… }
        slideshow_pager: { pager: {before?, after?}, pager_type: <id>, controls: bool }
        colorbox_image_style: <image_style|null>
        # + inherited ImageFormatter keys (image_style, image_link)
```

## `slideshow` keys (defaults from `defaultSettings()`)

| Key | Type | Default | Cycle2 meaning |
|---|---|---|---|
| `fx` | select | `fade` | Transition: `fade`, `fadeout`, `none`, `scrollHorz`. |
| `allowWrap` | bool | TRUE | Allow wrapping past the last/first slide. |
| `autoHeight` | text | `0` | Cycle2 auto-height mode. |
| `delay` | text | `0` | Milliseconds added/subtracted before the first transition. |
| `hideNonActive` | bool | TRUE | Hide inactive slides. |
| `loader` | select | `false` | Image loader: `true` / `false` / `wait`. |
| `loop` | number | `0` | Loop count; `< 1` = loop forever (allowWrap=false overrides). |
| `pauseOnHover` | bool | FALSE | Pause auto-play on mouse hover. |
| `paused` | bool | FALSE | Start paused. |
| `random` | bool | FALSE | Randomize initial slide order. |
| `reverse` | bool | FALSE | Play in reverse. |
| `speed` | number | `500` | Transition duration (ms). |
| `startingSlide` | number | `0` | Zero-based index of the first slide. |
| `swipe` | bool | FALSE | Touch swipe navigation (needs the cycle2 swipe plugin). |
| `sync` | bool | TRUE | Synchronize incoming/outgoing slide animation. |
| `timeout` | number | `4000` | Time between transitions (ms). |

(The stored config schema `field.formatter.settings.slideshow` is slightly out of date — it lists a
misspelled `deley` and omits `autoHeight`/`speed` typing — but `defaultSettings()` above is what the
formatter actually uses.)

## `slideshow_pager` keys

| Key | Type | Default | Meaning |
|---|---|---|---|
| `pager` | checkboxes | `{after: 'after'}` | Where to render the pager: `before` and/or `after`. |
| `pager_type` | select | `thumbnails` | Which `field_slideshow_pager` plugin renders it (`thumbnails`, `counter`, or custom). See [../plugins/pager.md](../plugins/pager.md). |
| `controls` | bool | TRUE | Render Prev/Next links. |

The pager is only rendered when the field has more than one image.

## Library loading (jQuery Cycle2)

- Asset library `field_slideshow/field_slideshow.cycle2` loads `/libraries/jquery.cycle2/jquery.cycle2.min.js`
  plus the module's `js/field_slideshow.js`. **You must install Cycle2 into the site `libraries/`
  directory** — it is not bundled and not a Composer dependency.
- With `swipe` enabled, `field_slideshow/field_slideshow.cycle2swipe`
  (`/libraries/jquery.cycle2/jquery.cycle2.swipe.min.js`) is also attached.
- Per-field Cycle2 options are emitted to `drupalSettings.field_slideshow[<unique_id>]`.

## Colorbox integration (optional)

When the `colorbox` module is enabled, the image-link select gains a **Colorbox** option and a
**Colorbox image style** select appears. Each slide then becomes a Colorbox gallery link
(`data-colorbox-gallery = gallery-<id>`); if an image style is chosen its derivative is built/created
for the lightbox image. Colorbox attachments are added via `colorbox.attachment` (soft dependency, not
injected).

## Set the formatter with Drush (example)

```php
// drush php:eval — put the slideshow formatter on node.article field_images
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_images', [
  'type' => 'slideshow',
  'region' => 'content',
  'settings' => [
    'slideshow' => ['fx' => 'fade', 'timeout' => 5000, 'speed' => 700, 'pauseOnHover' => TRUE],
    'slideshow_pager' => ['pager' => ['after' => 'after'], 'pager_type' => 'thumbnails', 'controls' => TRUE],
  ],
])->save();
```
