YouTube Field defines a `youtube` field type that stores a pasted YouTube video URL (and the extracted video ID), with widget and formatters to display it as an embedded iframe player or a downloaded thumbnail image. This release is a beta (`3.0.0-beta1`).

---

YouTube Field adds a dedicated `youtube` field type that you can attach to any content type, user, or other fieldable entity. Its widget accepts a YouTube URL in many formats (`watch?v=`, `youtu.be/`, `/embed/`, `/v/`, `/shorts/`, etc.), validates it, and extracts and stores a short `video_id` alongside the raw `input` URL. Three formatters render the field: `youtube_video` embeds a responsive-capable iframe player, `youtube_thumbnail` shows the video's thumbnail image (fetched from YouTube and saved locally so a Drupal image style can be applied), and `youtube_url` outputs the plain URL as text or a link. Player behavior is layered: global defaults live in the `youtube.settings` config object (edited at Admin -> Configuration -> Media -> YouTube Field, route `youtube.settings`), and many parameters can be overridden per field display -- video size (450x315, 480x360, 640x480, 960x720, responsive, or custom width/height), autoplay, mute, loop, control visibility, and annotation hiding. A privacy-enhanced mode switches the embed domain to `youtube-nocookie.com` so no cookies are set until playback. Thumbnails are downloaded via Guzzle to a configurable files subdirectory (hi-res `maxresdefault` when available, falling back to standard), registered as managed files, and can be refreshed (deleted) from the settings form. The module also exposes per-field tokens for the video URL and local image URL, and requires only core `field`, `image`, and `file`. It differs from core Media's oEmbed video, which stores videos as media entities from a remote-video source rather than as a simple scalar field value.

---

- Add a "YouTube video" field to a content type so editors paste a video URL instead of managing a media entity.
- Embed a responsive YouTube player that scales to the full width of its container.
- Display a fixed-size player (e.g. 640x480) chosen from the formatter's size options.
- Set custom width and height for an embedded player via the `custom` size option.
- Autoplay a hero video when the page loads.
- Mute a video by default (needed for reliable autoplay in modern browsers).
- Loop a background/showreel video continuously.
- Hide the player controls, or hide them only after playback begins.
- Hide video annotations (`iv_load_policy`) for a cleaner embed.
- Show a channel's own related videos only, by disabling suggested videos (`rel`).
- Hide the YouTube logo on the control bar with modest branding.
- Enable privacy-enhanced (`youtube-nocookie.com`) embeds for GDPR/cookie-consent compliance.
- Display a video's thumbnail image instead of an interactive player.
- Apply a Drupal image style (crop/resize) to the downloaded YouTube thumbnail.
- Link a thumbnail to the host entity's page, to the video on YouTube, or to nothing.
- Save higher-resolution (`maxresdefault`) thumbnails when the video provides them.
- Store downloaded thumbnails in a custom files subdirectory.
- Refresh (delete and re-fetch) all cached thumbnail images from the settings form.
- Output the raw YouTube URL as plain text or a clickable link with the `youtube_url` formatter.
- Accept many URL formats (`watch?v=`, `youtu.be/`, `/embed/`, `/shorts/`) from editors without manual normalization.
- Validate pasted input and reject non-YouTube URLs at form submission.
- Provide a placeholder/sample URL in the widget to guide editors.
- Add a YouTube field to a user profile or taxonomy term, not just nodes.
- Use the per-field `youtube_video_url` token to emit the canonical watch URL.
- Use the per-field `youtube_image_url` token to emit the local thumbnail URL, optionally through an image style.
- Enable the IFrame JS API (`enablejsapi`) for programmatic player control.
- Allow trusted editors to append extra player parameters (e.g. `&start=30`) via the override setting.
- Gate access to the global YouTube settings form with the `administer youtube` permission.
- Migrate a Drupal 7 YouTube field into Drupal 10/11 via the bundled migrate field plugin.
