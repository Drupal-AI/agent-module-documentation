<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie Content Blocker - Media blocks remote **oEmbed** media (YouTube, Vimeo, etc.) from loading until cookie consent is given, deciding per media provider. It ships a field formatter that wraps core's oEmbed output in the parent module's consent placeholder.

---

Submodule of `cookie_content_blocker` (requires it plus core `media` and `image`). It adds one field formatter, `cookie_content_blocker_oembed` ("Cookie Content Blocker - oEmbed content"), for `link`/`string`/`string_long` fields — a drop-in replacement for core's oEmbed formatter that extends it. On render it looks up the media entity's oEmbed `provider_name`, reads per-provider settings from `cookie_content_blocker_media.settings`, and if that provider is marked `blocked` it wraps the rendered embed with `#cookie_content_blocker` (message, category, and optional image-style thumbnail preview). A settings form at `…/cookie-content-blocker/media` (perm `administer cookie content blocker`) lists every media-source provider so you can toggle blocking, message, category, preview, and preview image style per provider. An optional `blocked_media_teaser` image style is installed for the preview thumbnail.

---

- Block YouTube videos in a Media field until marketing cookies are accepted.
- Block Vimeo (or any oEmbed provider) selectively while allowing others.
- Configure a different consent message per media provider.
- Show a thumbnail preview (via an image style) behind the consent message for blocked media.
- Assign blocked media to a cookie category so it reveals with that category's consent.
- Swap a Media reference field's display to the consent-aware oEmbed formatter.
- Keep GDPR compliance for embedded remote video without editing templates.
- Reuse the parent module's placeholder/button UX for media entities.
- Provide per-provider control (block provider A, allow provider B) from one settings form.
- Fall back to core oEmbed rendering for providers left unblocked.
- Use the shipped `blocked_media_teaser` image style for the preview thumbnail.
- Localise the per-provider blocked message.
- Vary render caching on the media settings config automatically.
- Let editors keep using standard Media fields while consent handling stays in the formatter.
- Combine with the parent's "consent awareness" mapping so accepted cookies reveal the video.
