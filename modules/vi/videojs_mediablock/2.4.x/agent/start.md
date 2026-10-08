# VideoJS Mediablock (videojs_mediablock) 2.4.x

![Add VideoJS Media Block content-block form (/block/add/videojs_mediablock)](../../../../../../screenshots/videojs_mediablock/2.4.x/add-form.png)
![Add-form continued: closed-captions, topics, save](../../../../../../screenshots/videojs_mediablock/2.4.x/add-form-2.png)

A custom content block that renders an ADA/508-compliant, responsive VideoJS player for a local, remote, or YouTube video/audio source, with optional poster image and closed-captions.

## Facts

- Ships one `block_content` type: `videojs_mediablock` (label "VideoJS Media Block", revisionable). Installed via `config/install/block_content.type.videojs_mediablock.yml`.
- The block carries ~11 fields, grouped by purpose:
  - Selection controls (list_string): `field_videojs_media_location` (required — Local vs Remote), `field_videojs_local` (Local media type), `field_videojs_remote` (Remote media type). The block edit form is a single AJAX interface driven by these.
  - Local media (entity_reference to media): `field_videojs_media_file` → media type `videojs_video`; `field_videojs_local_audio_file` → media type `videojs_audio`. (Both defined in `config/optional/`.)
  - Remote media (plain `string` fields holding a URL, emitted to the client player, not fetched server-side): `field_videojs_remote_media_file` (remote video URL), `field_videojs_remote_audio_file` (remote audio URL), `field_videojs_youtube` (YouTube watch/embed/playlist URL).
  - Poster/captions: `field_videojs_poster_image` (entity_reference to media `image`, Media Library enabled); `field_videojs_subtitle` (file field, extensions `vtt` only, max 1 MB, emitted as a `<track kind="captions">`).
  - Organization: `field_topics` (taxonomy reference to the `tags` vocabulary, optional).
- Two media types are created on install: `videojs_video` (source field `field_media_videojs_video_file`, extensions `mp4 webm ogv m3u8 mpd`) and `videojs_audio` (source field `field_media_videojs_audio_file`, extensions `mp3 wav ogg aac m4a`).
- Only the currently-selected media field renders. `hook_form_alter` reorganizes the form, applies permissions, and adds AJAX callbacks; `hook_entity_builder` + `hook_entity_presave` clear non-selected media fields; `hook_preprocess_field` / `hook_preprocess_block` / `hook_block_content_view` select which field renders the player (also what enables Views support). Logic lives in the `videojs_mediablock.helpers.*.inc` include files.
- Dependencies (info.yml): core `config`, `field`, `block_content`, `media`, `media_library`, `serialization`, `taxonomy`, `options`, `file`; plus the contrib module `file_upload_secure_validator` (MIME-type upload enforcement — configure allowed types at `/admin/config/media/file_upload_secure_validator`). Also requires the server-side `fileinfo` PHP extension and `npm`.
- Player library loading: the player is a Single Directory Component (`components/player/player.component.yml`, id `videojs_mediablock:player`). Its `libraryOverrides` attach JS/CSS from the module's own `node_modules/` directory — `video.js`, `@videojs/http-streaming` (HLS/DASH), `videojs-youtube`, `videojs-hotkeys`, `videojs-mobile-ui`, and the module's `player.js` — with `core/drupal` and `core/once` as dependencies. The site builder MUST run `npm install` inside the module directory; the libraries are NOT composer/PHP libraries and are NOT bundled.
- Templates: `templates/block--block-content--type--videojs-mediablock.html.twig` and `templates/field--block-content--videojs-mediablock.html.twig` both `{% include "videojs_mediablock:player" %}`. Theme hooks are registered in `hook_theme()` (`block__block_content__type__videojs_mediablock`, `field__block_content__videojs_mediablock`). Override the player by copying `components/player/` into a mirrored path in your theme.
- Permissions (`videojs_mediablock.permissions.yml`): `administer videojs mediablock` (restricted) plus per-source `use videojs local audio`, `use videojs local video`, `use videojs remote audio`, `use videojs remote video`, `use videojs youtube`. These gate which media fields an editor may use and are enforced in the form validate handler and on entity presave.
- No config schema directory, no Drush commands, no plugin types defined. Install-time config also creates the `tags` taxonomy vocabulary and default form/view displays. `hook_uninstall` removes all module config and `videojs_mediablock` blocks.
- Note (README, June 2026): the maintainer recommends new sites use the successor project VideoJS Media instead; this module is in maintenance.

## How to use (no code)

1. Enable the module and its dependencies, then run `npm install` in the module's directory so the VideoJS player libraries are present. Add the supported video/audio/caption MIME types at `/admin/config/media/file_upload_secure_validator`.
2. Create a player block at `/block/add/videojs_mediablock` (on Drupal CMS use `/block/add`).
3. Pick a media location — Local (upload/reference a file via the Media Library) or Remote (paste a direct media URL or a YouTube URL) — then choose audio or video; the form reveals the matching field via AJAX.
4. Optionally attach a poster image (shown before play) and upload a `.vtt` closed-captions file. Optionally tag the block with topics.
5. Save, then place the block via `/admin/structure/block`, Layout Builder, or a Views block. Manage existing blocks at `/admin/structure/block/block-content`.
