<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable & configure the Colorbox Media Remote Video formatter

No settings page, no configure route. You select the formatter per view display, on the field
that holds the remote-video URL (the core Remote Video media type's `field_media_oembed_video`).

## Via the UI

1. *Structure → Media types → Remote Video → Manage display*
   (`/admin/structure/media/manage/remote_video/display`).
2. On the **Video URL** row, choose format **Colorbox Media Remote Video**.
3. Click the cog to set options, **Update**, then **Save**.

## Where the setting is stored

Config entity `core.entity_view_display.<entity_type>.<bundle>.<view_mode>`, e.g.
`core.entity_view_display.media.remote_video.default`:

```yaml
content:
  field_media_oembed_video:
    type: colorbox_media_remote_video
    settings:
      max_width: 0            # inherited from the core oEmbed formatter
      max_height: 0
      display: thumbnail      # thumbnail | text | media_title
      link_text: 'View Video' # used only when display = text
      image_style: thumbnail  # used only when display = thumbnail
      colorbox_gallery: post  # post|page|field_post|field_page|custom|none
      colorbox_gallery_custom: ''
      colorbox_caption: auto  # auto|title|alt|entity_title|custom|none
      colorbox_caption_custom: ''
```

## Settings keys

| Key | Values / meaning |
|---|---|
| `display` | `thumbnail` (image launcher), `text` (link text), `media_title` (entity label as link) |
| `link_text` | Text shown when `display = text` (default "View Video") |
| `image_style` | Image style for the thumbnail when `display = thumbnail`; empty = original |
| `colorbox_gallery` | Grouping (Colorbox `rel`): `post`, `page`, `field_post`, `field_page`, `custom`, `none` |
| `colorbox_gallery_custom` | Token/string gallery id when `colorbox_gallery = custom` |
| `colorbox_caption` | Caption source: `auto` (title→alt→content title), `title`, `alt`, `entity_title`, `custom`, `none` |
| `colorbox_caption_custom` | Token/string caption when `colorbox_caption = custom` |

Plus the inherited core oEmbed settings (`max_width`, `max_height`). Token replacement in the
two `*_custom` fields requires the `token` module; without it the settings form shows a notice.

## Via drush php:eval (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('media.remote_video.default');
$vd->setComponent('field_media_oembed_video', [
  'type' => 'colorbox_media_remote_video',
  'label' => 'hidden',
  'settings' => [
    'display' => 'thumbnail',
    'image_style' => 'thumbnail',
    'colorbox_gallery' => 'page',
    'colorbox_caption' => 'auto',
  ],
])->save();
```

## Read it back

```bash
drush cget core.entity_view_display.media.remote_video.default content.field_media_oembed_video
# type should be colorbox_media_remote_video; settings hold display/colorbox_gallery/colorbox_caption
```

The formatter also accepts plain `link` / `string` / `string_long` fields, but its preprocess
expects the entity to expose a `thumbnail` field (as media entities do), so use it on a media
type with a thumbnail for correct rendering.
