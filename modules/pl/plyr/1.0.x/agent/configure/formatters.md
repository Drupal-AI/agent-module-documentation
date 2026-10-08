# Configure the Plyr formatters

No usable global settings page (the `plyr.settings` form defines no fields). You configure Plyr per
field on the entity's **Manage display** tab (`admin/structure/…/display`): pick a Plyr formatter, then
open its cog to set options. Settings persist in the `entity_view_display` config entity.

## The three formatters

| Formatter id | Field types | Applies to | Renders |
|---|---|---|---|
| `plyr_remote_video` | `link`, `string`, `string_long` | **media** entity whose source is oEmbed (`isApplicable` requires `media` + `OEmbedInterface`) | `plyr_remote_video` theme element |
| `plyr_file_video` | `file` | file fields (extends core `FileVideoFormatter` base) | core video markup + `plyr` classes |
| `plyr_file_audio` | `file` | file fields | core audio markup + `plyr` classes |

`plyr_remote_video` only accepts **YouTube** and **Vimeo** URLs. The stored value is passed to the core
`media.oembed.url_resolver`; the provider name is lowercased and checked against `['vimeo','youtube']`
(anything else → the item is skipped). The embed id is extracted with `VIMEO_ID_REGEX` /
`YOUTUBE_ID_REGEX` and placed in `data-plyr-embed-id`.

## Settings keys (`defaultSettings()`, shared by all three via `PlyrSharedFormatterTrait`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `autoplay` | bool | `false` | Autoplay on load (often blocked by browsers). |
| `loop` | bool | `false` | Loop the media. |
| `resetOnEnd` | bool | `true` | Return to start when playback completes. |
| `hideControls` | bool | `true` | Auto-hide controls after ~2s of inactivity / on play / fullscreen. |
| `controls` | map of bool | see below | Which control buttons to show. |
| `youtube.noCookie` | bool | `true` | Use the `youtube-nocookie.com` domain. |

`controls` sub-keys (default enabled = ✓): `play-large`, `restart`, `rewind`, `play`✓, `fast-forward`,
`progress`✓, `current-time`✓, `duration`, `mute`✓, `volume`✓, `captions`, `settings`✓, `pip`, `airplay`,
`fullscreen`✓.

## How settings reach the browser

`buildPlyrDrupalSettings()` compacts the config: only *enabled* controls are kept (as a list),
`youtube` becomes an object of enabled flags, and any other truthy scalar setting is emitted as `true`.
The result is set on `#plyr_settings`, JSON-encoded into the `data-plyr-config` HTML attribute, and read
by `js/plyr-player.js` → `Plyr.setup('.plyr-player', {i18n: …})`. No schema file ships, so these settings
are stored as free-form formatter settings.

## Set the remote-video formatter with Drush (example)

```php
// drush php:eval — put the Plyr player on the core "field_media_oembed_video" of a remote_video media type.
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('media.remote_video.default');
$vd->setComponent('field_media_oembed_video', [
  'type' => 'plyr_remote_video',
  'label' => 'hidden',
  'settings' => [
    'autoplay' => FALSE,
    'loop' => FALSE,
    'controls' => ['play' => TRUE, 'progress' => TRUE, 'fullscreen' => TRUE, 'mute' => TRUE, 'volume' => TRUE],
    'youtube' => ['noCookie' => TRUE],
  ],
])->save();
```

## Library / CDN

The `plyr/plyr` asset library references **Plyr 3.7.8 from cdn.plyr.io** (external JS + CSS). The
`plyr/plyr-player` library adds `js/plyr-player.js` and depends on `plyr/plyr` + `core/drupal`. There is
no built-in switch to self-host; override with a `hook_library_info_alter()` in a custom module if you
need to avoid the CDN.
