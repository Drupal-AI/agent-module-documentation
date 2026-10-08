<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed Twitter adds a Twitter provider to Video Embed Field. Editors paste a tweet URL and the field renders a Twitter video iframe pointed at `https://twitter.com/i/videos/tweet/{id}`.

---

`getIdFromInput()` parses the input with a strict regex that only accepts `twitter.com/i/status/<numeric-id>`, so the video ID is constrained to digits. The embed is a Drupal `html_tag` iframe whose `src` is built with `sprintf` from that numeric ID, and render-array attribute escaping applies — there is no raw-markup or unescaped-attribute XSS sink, and no server-side URL fetch (no SSRF). The provider is functionally dated (Twitter's `/i/videos/tweet/` endpoint and the numeric-only URL pattern predate X changes), so embeds may no longer resolve, but there is no security concern.

---

- Embed a Twitter/X video into content by tweet URL.
- Render a tweet's video in an iframe player.
- Add Twitter as a Video Embed Field provider.
- Reuse VEF widgets and formatters for tweet videos.
- Accept only `twitter.com/i/status/<id>` URLs.
- Constrain the parsed video ID to digits.
- Set iframe width/height via formatter options.
- Mix Twitter videos with other VEF providers in one field.
- Display social-video content on nodes.
- Keep the embed markup escaped via html_tag.
- Avoid granting Twitter JS access to the page (iframe approach).
- Provide a lightweight iframe instead of Twitter's JS widget.
- Use on standard or media-source VEF fields.
- Verify current Twitter/X embed availability before relying on it.
- Pair with responsive-embed styling for players.
- Fall back to another provider if tweets no longer resolve.
