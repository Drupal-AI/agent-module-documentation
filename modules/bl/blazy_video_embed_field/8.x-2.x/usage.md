<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Blazy Video Embed Field bridges the Video Embed Field and Blazy modules, giving embedded videos Blazy's lazy-loading and display handling through dedicated field formatters.

Use it when you already use Video Embed Field and want Blazy to lazy-load the thumbnails/players.

---

Install with `composer require drupal/blazy_video_embed_field` and enable it (`drush en blazy_video_embed_field`). It requires `video_embed_field` (video_embed_media) and `blazy` (>= 8.x-2.x).

On a Video Embed Field's Manage Display, choose the Blazy-based formatter (player or Blazy display) to render the video with Blazy features.

---

- Add Blazy-powered formatters to Video Embed fields.
- Lazy-load video thumbnails and players via Blazy.
- Provide a player formatter for embedded videos.
- Reuse Blazy's responsive/display features for video.
- Depend on Video Embed Field and Blazy.
- Configure via the field's Manage Display screen.
- Improve perceived performance on video-heavy pages.
- Support Drupal 8, 9 and 10.
- Require no custom routes or permissions.
- Integrate as field-formatter plugins only.
- Share a trait for common Blazy/video logic.
- Work with the existing Video Embed Field data.
- Defer offscreen video loading.
- Keep configuration within Field UI.
- Complement Blazy's image lazy-loading with video.
- Reduce initial page weight.
- Serve as a thin integration layer between two contrib modules.