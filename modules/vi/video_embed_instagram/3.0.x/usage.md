<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Instagram adds Instagram as a provider for Video Embed Field, so an Instagram video URL pasted into a video field renders as an embed alongside YouTube and Vimeo.

---

Video Embed Field's design is a provider plugin per platform, and this module is exactly that — a single provider plugin in `src/Plugin`, plus tests, an info file and a licence. There is no configuration, no permission, no route and no service. Composer requires `video_embed_field ^3` and core `^10.3 || ^11`, and the release is **3.0.0-beta1**. The thing to weigh before adopting it is not the code, which is minimal, but the platform: Instagram's embed behaviour and API terms have changed repeatedly, embeds generally require the post to remain public, and rendering one loads Meta's script into the visitor's browser — which is a third-party tracking consideration and, on a site with a consent manager such as `simple_klaro`, something that ought to be gated behind consent rather than loaded unconditionally. A beta release integrating a platform that changes its embed rules is worth version-pinning and periodically re-testing.

---

- Embed an Instagram video in an article.
- Add Instagram alongside YouTube and Vimeo.
- Let editors paste an Instagram URL into a video field.
- Show social video in a consistent field.
- Reuse Video Embed Field's formatters for Instagram.
- Display a campaign's Instagram content on site.
- Avoid manual embed-code pasting.
- Keep video handling uniform across providers.
- Show an influencer video on a landing page.
- Render Instagram video in a Views listing.
- Support a marketing team's social content.
- Add Instagram to an existing video field.
- Use Video Embed Field thumbnails for Instagram.
- Embed a product demo posted to Instagram.
- Gate Instagram embeds behind consent.
- Standardise social video presentation.
- Migrate hardcoded embeds into a field.
- Support Drupal 11 with an Instagram provider.
