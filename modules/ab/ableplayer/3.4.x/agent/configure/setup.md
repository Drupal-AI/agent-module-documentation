<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Able Player — setup & display configuration

There is **no admin settings form** (`configure` is null). Configuration is: enable the module (which
auto-provisions fields/displays), then make sure each media type's *Manage display* uses an Able
Player formatter.

## What install does automatically (`hook_modules_installed`)

For every Media type whose source is `video_file` or `audio_file`, it creates (if missing) and adds
to the default form display:

| Field | Type | Purpose |
|---|---|---|
| `field_ableplayer_media_caption` | entity_reference → media (`able_player_caption`) | Caption media (VTT), supports translation for multi-language captions |
| `ableplayer_description` | file (`vtt`) | Text audio-description track |
| `ableplayer_chapter` | file (`vtt`) | Chapter markers |
| `ableplayer_sign_language` | file (`mp4`) | Sign-language companion video |
| `ableplayer_poster_image` | file (`jpg png`) | Poster image before playback |

For Media types with source `oembed:video` (Remote Video) it adds string fields
`ableplayer_audio_description` (YouTube/Vimeo URL) and `ableplayer_remote_sign_language`
(YouTube-only URL). (Update hooks `9001`–`9003` backfill these on existing oEmbed types.)

It also ships the **`able_player_caption`** media type (`config/optional/`), source field
`ableplayer_caption` (a VTT file), used as the caption reference target.

Install additionally sets, for local `video`:
- form display `field_ableplayer_media_caption` → `media_library_widget`;
- view display `field_media_video_file` → formatter `ableplayer_video` with settings
  `controls=false, autoplay=false, loop=false, multiple_file_display_type=tags`.

`hook_file_default_types_alter` adds `text/vtt` to the `document` file type so VTT uploads validate.

## Applying the formatters (Manage display)

If a media type wasn't auto-configured (or you added new types), set the file/URL field's format:

- Local video (`video`): field `field_media_video_file` → **Ableplayer Video** (`ableplayer_video`).
- Local audio (`audio`): the audio file field → **Ableplayer Audio** (`ableplayer_audio`).
- Remote video (`remote_video`): the source URL field → **Ableplayer Remote Video**
  (`ableplayer_remote_video`).

The video/audio formatters pull in the related fields automatically at render: caption (via the
`able_player_caption` view mode), chapters, sign language, and poster image. Formatter settings
(schema `field.formatter.settings.*`): `controls`, `autoplay`, `loop` (bool) and
`multiple_file_display_type` (string).

The **remote** formatter (`AbleplayerRemoteVideoFormatter`) resolves the URL provider with
`media.oembed.url_resolver`, extracts the YouTube/Vimeo id (and ids from
`ableplayer_audio_description` / `ableplayer_remote_sign_language`), and renders the
`ableplayer_remote_video` theme with `data-youtube-id` / `data-vimeo-id` (+ desc/sign ids).

## Multi-language captions

1. `drush en content_translation -y` and add languages at `/admin/config/regional/language`.
2. Content → Media → Add **Able Player Caption**, upload the primary-language VTT, save.
3. Translate that caption media entity, uploading a VTT per language.
4. Reference the caption media from the video via `field_ableplayer_media_caption`.

`AbleplayerCaptionFormatter::getSourceFiles()` emits one `<track>` per translation with
`src`/`srclang`/`label` set from each language.

## Reinstall note

After uninstall+reinstall, re-save `/admin/structure/media/manage/video/display` so the
`ableplayer_video` view-mode formatter is applied again to local videos.

## Requirements

Core `media` + `media_library`. No Composer libraries (`composer.json` absent; the Able Player JS is
vendored under `js/`). No permissions or Drush commands are provided.
