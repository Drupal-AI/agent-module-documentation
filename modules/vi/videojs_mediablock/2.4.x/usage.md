VideoJS Mediablock ships a reusable content block that renders an ADA/508-compliant, responsive VideoJS player for a locally uploaded, remotely hosted, or YouTube-sourced video or audio file, with optional poster image and closed-captions.

---

VideoJS Mediablock installs a `block_content` type named `videojs_mediablock` and drives it with the mature open-source VideoJS player library. On installation it also creates two media types — `videojs_video` (source field accepts `mp4 webm ogv m3u8 mpd`) and `videojs_audio` (`mp3 wav ogg aac m4a`) — plus a `tags` taxonomy vocabulary for a topics field. The block presents a single AJAX-driven form where the editor first chooses a media location (Local or Remote), then a media type (audio or video); depending on that choice one of several fields becomes active: local video (`field_videojs_media_file`) and local audio (`field_videojs_local_audio_file`) reference uploaded media entities via the Media Library, while remote video (`field_videojs_remote_media_file`), remote audio (`field_videojs_remote_audio_file`), and YouTube (`field_videojs_youtube`) accept a URL string that is passed straight to the player and played client-side (nothing is downloaded to the server). An optional poster image (`field_videojs_poster_image`, a Media Library image reference) shows until playback starts, and an optional closed-captions file (`field_videojs_subtitle`, a `.vtt` upload capped at 1 MB) is emitted as a `<track kind="captions">`. Only the currently-selected media field is rendered — a `hook_form_alter` reorganizes the form and applies granular permissions, `hook_entity_presave`/`hook_entity_builder` clear the non-selected media fields, and `hook_preprocess_field`/`hook_preprocess_block` decide which field renders the player (this also enables Views support). The player itself is a Single Directory Component at `components/player/player.twig` (component id `videojs_mediablock:player`); its `player.component.yml` attaches the VideoJS JS/CSS through `libraryOverrides` that reference files under the module's `node_modules/` directory (video.js, `@videojs/http-streaming` for HLS/DASH, videojs-youtube, videojs-hotkeys, and videojs-mobile-ui), so the site builder must run `npm install` inside the module folder after enabling it. The player is fluid/responsive, supports keyboard hotkeys, mobile UI, and only one player per page plays at a time.

---

- Install the module, then run `npm install` in the module's directory to fetch the VideoJS player libraries before using it.
- Add MIME types for the supported video, audio, and caption formats at `/admin/config/media/file_upload_secure_validator` as described in the README.
- Create a new player block at `/block/add/videojs_mediablock` (or `/block/add` on Drupal CMS).
- Choose "Local" hosting and upload a video file (MP4, WebM, OGG, HLS, or DASH) through the Media Library.
- Choose "Local" hosting and upload an audio file (MP3, WAV, OGG, AAC, M4A) for a podcast or music clip.
- Choose "Remote" hosting and paste a direct video URL (e.g. `https://example.com/video.mp4`) to stream without storing the file locally.
- Choose "Remote" hosting and paste a direct audio URL to play remotely-hosted audio.
- Paste a YouTube watch, embed, or playlist URL to embed a YouTube video in the player.
- Stream adaptive-bitrate HLS (`.m3u8`) or DASH (`.mpd`) sources for higher-quality playback.
- Add an optional poster image that displays until the viewer presses play.
- Upload a `.vtt` closed-captions/subtitle file to make a video ADA/508 accessible.
- Tag blocks with the provided `tags` taxonomy topics field for organization and filtering.
- Place a finished block anywhere via `/admin/structure/block`, Layout Builder, or a Views block.
- Build a Content Block view, filter by VideoJS Mediablocks or taxonomy, and render the entity to list many players.
- Grant editors only the media sources they should use (local audio, local video, remote audio, remote video, YouTube) through the module's permissions.
- Manage all created player blocks from `/admin/structure/block/block-content`.
- Custom-theme the player by copying `components/player/` into a matching path in your theme (Single Directory Component override).
- Combine with the Block Field module to place a player as a per-entity field instead of a positioned block.
- Rely on the built-in mobile UI and hotkeys (space, arrows, M, F, number keys) for a keyboard- and touch-friendly player.
- Add multiple player blocks to one page knowing that starting one automatically pauses the others.
