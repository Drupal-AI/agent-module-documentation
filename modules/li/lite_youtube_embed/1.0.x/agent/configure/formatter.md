# Use the Lite YouTube embed formatter

No configure route. You select the formatter on a **media** type's *Manage display*, or set it in the
`entity_view_display` config.

## Where it applies

Formatter id **`lite_youtube_embed`**. `isApplicable()` returns true only when:

- the field's target entity type is **`media`**, and
- the media type's source is an **oEmbed** source (`OEmbedInterface`) — e.g. the standard
  **Remote video** type, whose source field is `field_media_oembed_video`.

Field types it accepts: `link`, `string`, `string_long`. It will not appear on non-media entities.

## Set it via the UI

1. Go to the media type's *Manage display*, e.g. Remote video:
   `/admin/structure/media/manage/remote_video/display`.
2. For the oEmbed video field, choose the **"Lite YouTube embed (with oEmbed fallback)"** format.
3. Optionally set **Maximum width/height** (these apply only to the non-YouTube oEmbed fallback).
4. **Save**.

## Where it is stored

Config entity `core.entity_view_display.media.<bundle>.<view_mode>`:

```yaml
content:
  field_media_oembed_video:
    type: lite_youtube_embed
    settings:
      max_width: 0
      max_height: 0
```

Set by script:
```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('media.remote_video.default');
$vd->setComponent('field_media_oembed_video', [
  'type' => 'lite_youtube_embed',
  'settings' => ['max_width' => 0, 'max_height' => 0],
  'label' => 'hidden', 'weight' => 0, 'region' => 'content',
])->save();
```

Schema: `field.formatter.settings.lite_youtube_embed` (`max_width`, `max_height` integers).

## Rendering logic (what you get)

Per value the formatter resolves the oEmbed resource, then:

- **YouTube** + a parseable 11-char id → `#theme => 'lite_youtube_embed'` (`<lite-youtube videoid>`),
  attaching library `lite_youtube_embed/lite_youtube_embed`. `max_width`/`max_height` are **not** used
  for YouTube.
- **Other provider / photo / link** → the core oEmbed iframe (library `media/oembed.formatter`),
  image, or link — the normal fallback, honouring `max_width`/`max_height`.

YouTube URL forms parsed: `watch?v=`, `youtu.be/`, `embed/`, `/v/`, `/shorts/` (with optional
`www.`/`m.` and scheme).

## Required JavaScript library (not bundled)

`lite_youtube_embed.libraries.yml` references the library from `/libraries/lite-youtube-embed/src`
(`lite-yt-embed.js` + `.css`). Install Paul Irish's
[lite-youtube-embed](https://github.com/paulirish/lite-youtube-embed) there — download it manually,
or use Asset Packagist / `npm-asset/lite-youtube-embed` with `oomphinc/composer-installers-extender`.
Without the library the `<lite-youtube>` element renders but is not upgraded/interactive.
