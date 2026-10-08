Audio Video Viewer is a Drupal field formatter that plays uploaded audio and video files inline using the browser's native HTML5 `<audio>` and `<video>` players.

---

The module adds one field formatter (plugin id `audio_video_viewer`) that can be selected for any core **File** field on a bundle's *Manage display*. For each attached file it decides whether the file is audio or video by combining its extension (matched against a per-site allow-list of supported extensions, or "allow all") with its MIME-type prefix, then renders a native HTML5 player with configurable width/height, preload strategy, an optional file name link, and an optional file-size label. Recognised files play inline; unrecognised files, oversized files, or files with an invalid configured size degrade to a plain download link (or to nothing, if "disable all content if not recognized" is on, so it can be chained with the fallback_formatter module). A site-wide settings form at `/admin/config/user-interface/audio_video_viewer` controls which extensions count as audio vs video.

---

- Play an uploaded MP3, OGG, or WAV audio file inline on a node using the browser's audio controls.
- Play an uploaded MP4, WebM, or OGG video file inline with native video controls.
- Turn an existing core File field into a media player without adding the full Media module stack.
- Display podcast episodes attached as file-field uploads with a working play/pause bar.
- Show short screen-recording or demo videos attached to documentation nodes.
- Present lecture or training audio directly in the page instead of forcing a download.
- Set a fixed video size (e.g. `640px` wide by `360px` tall) for consistent layout across a content type.
- Let videos auto-fit the available column width by leaving "Autofit video size" on.
- Let the browser choose the audio player's natural width, or pin it to a fixed `px`/`%` width.
- Control bandwidth on page load by choosing preload `none`, `metadata`, or `auto` per audio and per video.
- Show the file's name as a clickable download link above the player for accessibility or archival.
- Show each file's size in bytes next to or instead of the player.
- Cap playback rendering to a maximum file size in bytes, sending anything larger to a download link.
- Render every file in a field as audio (or as video) regardless of extension via the "allow all extensions" site setting.
- Restrict which extensions are treated as audio vs video by editing the space-separated supported-extension lists.
- Handle a file that qualifies as both audio and video (e.g. `.ogg`) by falling back to its MIME-type prefix to pick the player.
- Combine with the fallback_formatter module: enable "disable all content if file format not recognized" so another formatter can take over unsupported files.
- Attach multiple audio/video files to one multi-value file field and render a player for each delta.
- Provide a graceful download-link fallback for browsers or files the native player cannot handle.
- Style the players site-wide by overriding the `audio-tag.html.twig` / `video-tag.html.twig` templates in a theme.
- Keep media playback self-hosted (no third-party embed or CDN player) for privacy-sensitive sites.
