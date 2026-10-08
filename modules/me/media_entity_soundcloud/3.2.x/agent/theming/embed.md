<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The embed: `soundcloud_embed` formatter, theme hook & template

## Formatter `soundcloud_embed`

`Drupal\media_entity_soundcloud\Plugin\Field\FieldFormatter\SoundcloudEmbedFormatter`
(field types `link`, `string`, `string_long`; only applicable on `media` entities). It reads the
media's `source_id` metadata and renders the `media_soundcloud_embed` theme hook.

Default settings (`defaultSettings()`):

| Setting | Default | Notes |
|---|---|---|
| `type` | `visual` | `visual` (large artwork) or `classic` (compact). |
| `width` | `100%` | Iframe width. |
| `height` | `450` | Iframe height in px. Suggested: 450 visual, 166 classic. |
| `color` | `#ff5500` | Play-button/accent color (hex). |
| `options` | `[]` | Checkbox set — see below. |

`options` is a checkboxes set; enabled keys are stored. Available keys (`getEmbedOptions()`):
`auto_play`, `hide_related`, `show_artwork`, `show_playcount`, `show_comments`, `show_user`,
`show_reposts`, `download`, `buying`, `sharing`, `show_teaser` ("Show SoundCloud Overlays"),
`single_active` (when off, multiple players on a page don't toggle each other).

Stored at `core.entity_view_display.media.<type>.<mode>` →
`content.<source_field>.settings` with those keys.

## Theme hook & template

`media_soundcloud_embed` (declared in `media_entity_soundcloud_theme()`, preprocess in
`media_entity_soundcloud.theme.inc`). Template: `templates/media-soundcloud-embed.html.twig`.

Variables: `source_id`, `width`, `height`, `type`, `color`, `options`, `title`, and (added by
preprocess) `url`.

`template_preprocess_media_soundcloud_embed()` builds the player URL:

- base `https://w.soundcloud.com/player/`
- query `url = https://api.soundcloud.com/<source_id>` (e.g. `.../tracks/12345`)
- `visual = true|false` (from `type == 'visual'`)
- each enabled option → `<option>=true|false` (a stored `'0'` becomes `false`, anything else `true`)
- `color` if set.

The template then outputs:

```twig
<iframe width="{{ width }}" height="{{ height }}" scrolling="no" frameborder="no"
        src="{{ url }}" title="{{ title }}"></iframe>
```

Override by copying `media-soundcloud-embed.html.twig` into your theme (e.g. to add a wrapper,
lazy-loading, or `loading="lazy"`), or implement `hook_preprocess_media_soundcloud_embed()` to
adjust the computed `url`/variables.
