<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Panopto adds Panopto as a provider for Video Embed Field, so a Panopto lecture-capture URL pasted into a video field renders as an embedded Panopto player.

---

Install it with Composer (`composer require drupal/video_embed_panopto`) and enable it — its one dependency, **Video Embed Field**, is pulled in automatically — then there is nothing to configure in the module itself: it has no settings page, permissions, or routes. All the real work happens in Video Embed Field: add a **Video Embed** field to a content type (or use the Video Embed WYSIWYG dialog / a Video Embed media type), and set the field's display formatter to **Video** (the embedded iframe player), **Video URL**, or **Thumbnail** (a preview image, optionally linked to the video). This module teaches Video Embed Field to recognise two Panopto URL shapes — `https://<your-institution>.hosted.panopto.com/Panopto/Pages/Viewer.aspx?id=<session-id>` and the equivalent `…/Pages/Embed.aspx?id=<session-id>` — so an editor just pastes the URL from Panopto's **Share** dialog into the field. The player's width, height, autoplay and responsive behaviour all come from Video Embed Field's formatter settings, and the teaser thumbnail is fetched from Panopto's Public API (`SessionPreviewImage`). Because the embed URL carries your institution's own Panopto server hostname, embeds work for whichever audience Panopto itself permits — much Panopto content is limited to signed-in members of the institution, so confirm a session's folder is public before expecting anonymous site visitors to see it.

---

- Embed a recorded lecture in a course page.
- Add Panopto as a provider on a Video Embed field.
- Paste a Panopto `Viewer.aspx` share URL and have it play inline.
- Paste a Panopto `Embed.aspx` URL into a video field.
- Show a seminar or webinar recording on a site.
- Use the Video formatter for an embedded Panopto iframe player.
- Use the Thumbnail formatter to show a Panopto preview image.
- Link a Panopto thumbnail to the full node or the provider page.
- Set player width, height, autoplay and responsive sizing via Video Embed Field.
- Reuse Video Embed Field's formatters and widgets for Panopto videos.
- Embed Panopto videos inside body text with the Video Embed WYSIWYG dialog.
- Create a Panopto-backed media type via Video Embed Media.
- Render Panopto alongside YouTube and Vimeo in the same field.
- Provide a consistent video field across multiple providers.
- Keep lecture video hosted on the institutional Panopto platform.
- Embed a departmental video-library item or induction recording.
- Add lecture capture to a Drupal site without writing custom code.
- Pull a Panopto session's preview image for use as a teaser.
- Support a university or college education media workflow.
- Migrate/standardise course pages onto Panopto embeds.
