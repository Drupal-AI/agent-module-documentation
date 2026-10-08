<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Kaltura Video Embed Field adds a Kaltura provider to the Video Embed Field module. An admin sets the Kaltura Partner ID and Uiconf ID; editors paste a Kaltura URL, and the field renders a Kaltura iframe player and thumbnail.

---

`getIdFromInput()` validates the input with `FILTER_VALIDATE_URL` and checks the host ends in `kaltura.com` before extracting the entry ID from fixed path segments (`id`/`media`/`entry_id`), so arbitrary hosts are rejected. The embed is built as a Drupal `html_tag` render element whose `src` is assembled with `sprintf` from admin config (partner/uiconf IDs) and the constrained entry ID; render-array attribute escaping applies, so this is not a raw-markup XSS sink. There is no server-side fetch of a request-supplied URL (no SSRF). The settings route uses a custom `kaltura settings` permission. Minor smell: `renderEmbedCode()` reads config via `getEditable()` (read-only would suffice) and `getRemoteThumbnailUrl()` hardcodes an unrelated partner ID.

---

- Embed Kaltura-hosted videos in Video Embed Field fields.
- Render a Kaltura iframe player on nodes and media.
- Configure a site-wide Kaltura Partner ID and Uiconf ID.
- Accept only `kaltura.com` URLs for the video source.
- Extract the entry ID from `id`/`media`/`entry_id` URL patterns.
- Provide a Kaltura thumbnail for video teasers.
- Reuse existing Video Embed Field formatters and widgets.
- Restrict Kaltura settings to the `kaltura settings` permission.
- Toggle autoplay through the standard VEF formatter options.
- Serve enterprise/LMS video via Kaltura players.
- Add Kaltura alongside YouTube/Vimeo VEF providers.
- Set player dimensions from field formatter settings.
- Keep the embed markup escaped via the html_tag render element.
- Confirm partner/uiconf IDs from your Kaltura account.
- Review the hardcoded thumbnail partner ID if thumbnails misbehave.
- Use on media-source or plain VEF fields.
- Pair with responsive-embed CSS for fluid players.
