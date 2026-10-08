<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Able Player integrates the accessible [Able Player](https://github.com/ableplayer/ableplayer) JavaScript media player into Drupal's Media system, rendering audio, local video, and remote (YouTube/Vimeo) video with captions, chapters, audio description, sign-language video, and a poster image.

---

On install (`hook_modules_installed`) the module programmatically creates a set of fields on the
site's Media types and wires up display: on `video_file`/`audio_file` media it adds
`field_ableplayer_media_caption` (entity reference to a dedicated **Able Player Caption** media
type), plus file fields `ableplayer_description` (VTT), `ableplayer_chapter` (VTT),
`ableplayer_sign_language` (MP4) and `ableplayer_poster_image` (JPG/PNG); on `oembed:video`
(remote video) media it adds string fields `ableplayer_audio_description` and
`ableplayer_remote_sign_language` for YouTube/Vimeo URLs. It ships the **Able Player Caption** media
type (`config/optional/media.type.able_player_caption.yml`, source field `ableplayer_caption`, a VTT
file) whose translations provide multi-language captions. Seven field formatters render the pieces —
`ableplayer_video`, `ableplayer_audio`, `ableplayer_caption`, `ableplayer_chapter`,
`ableplayer_sign_language`, `ableplayer_poster_image`, and `ableplayer_remote_video` — and the
install sets the local `video` media's file field to the `ableplayer_video` formatter. The remote
formatter uses core's oEmbed URL resolver to detect YouTube vs Vimeo and extract the video id,
emitting `data-youtube-id`/`data-vimeo-id` (and description/sign-language ids) onto a
`<video data-able-player>` element. Templates (`ableplayer_video`, `ableplayer_audio`,
`ableplayer_remote_video`, caption/chapter/sign-language/poster) attach the `ableplayer/ableplayer`
library (Able Player 5.0.0 CSS/JS + jQuery + a CDN-hosted js-cookie; Vimeo uses the CDN Vimeo player
API) and build the `<video>`/`<audio>` markup. The module has no settings form (`configure` is null),
no permissions or Drush of its own, and depends on core `media` and `media_library`.

---

- Play uploaded video files with the accessible Able Player instead of the plain HTML5 player.
- Play uploaded audio files with Able Player controls.
- Add closed captions to a video from an uploaded VTT file.
- Provide captions in multiple languages via translated Able Player Caption media entities.
- Add a text audio-description track (VTT) to a local video.
- Add chapter markers to a video from a VTT chapters file.
- Attach a sign-language companion video (MP4) shown alongside the main video.
- Set a poster image displayed before a video plays.
- Embed and play a YouTube video through Able Player via a Remote Video media entity.
- Embed and play a Vimeo video through Able Player.
- Provide a YouTube audio-described alternate that viewers can toggle.
- Provide a YouTube sign-language video for a remote video.
- Deliver WCAG-friendly media with keyboard-accessible, screen-reader-aware controls.
- Reuse Drupal Media Library to manage all player assets (video, captions, poster, etc.).
- Offer transcript/controls consistent with the Able Player demos across the site.
- Localize captions by enabling core Content Translation and translating caption media.
- Render Able Player video inside any entity that references the media (node, paragraph, etc.).
- Switch an existing Video media type's display to the Able Player formatter.
- Add the `text/vtt` mime type support for caption/description/chapter uploads.
- Present audio content with captions using the audio formatter.
- Toggle player options (controls/autoplay/loop) per display via the formatter settings.
- Provide accessible media for compliance (Section 508 / WCAG) requirements.
- Serve a poster + sign language + captions combination for fully accessible video.
- Reinstall/re-apply the Able Player display on a media type by re-saving its Manage display form.
