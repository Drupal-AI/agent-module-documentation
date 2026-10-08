<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Video Embed JW Player adds JW Player / JW Platform as a provider for Video Embed Field, so a JW Player embed or preview URL pasted into a video field renders as an embedded player with a cached thumbnail.

---

Install it alongside its required dependency **Video Embed Field** (`composer require drupal/video_embed_jwplayer`, then enable both at Extend or with `drush en video_embed_jwplayer`). There is nothing to configure — the module has no settings page. To use it, add a **Video Embed** field to a content type (or use the module's media source / the WYSIWYG button that Video Embed Field provides), then when creating content paste a JW Player URL such as `//content.jwplatform.com/players/MEDIAID-PLAYERID.html` (iframe), `//cdn.jwplayer.com/players/MEDIAID-PLAYERID.js` (JS), or `https://cdn.jwplayer.com/previews/MEDIAID-PLAYERID` (preview) — any `//subdomain.jwplayer.com/…/MEDIAID-PLAYERID` or legacy `jwplatform.com` URL is accepted. On display the field renders an `<iframe src="//content.jwplatform.com/players/MEDIAID-PLAYERID.html">` sized by the formatter's **width**/**height** settings, and the poster image is fetched once from `https://cdn.jwplayer.com/thumbs/MEDIAID-720.jpg` and cached locally. Only the **Cloud** flavours of JW Player are supported (JW Player Cloud + JW Platform, and JW Player Cloud + externally-hosted content); self-hosted JW Player builds are not. Because JW Player is a paid, self-branded hosting product, remember it is still a third-party embed (cookies, a reported view) so apply the same consent policy you would to YouTube, and note that provider plugins break if JW Player changes its embed URL format — check the module's release date against the platform's current behaviour.

---

- Embed a JW Player Cloud hosted video on a page.
- Add a JW Platform video to a content type.
- Paste a JW Player iframe embed URL into a video field.
- Paste a JW Player JS embed URL (`.js`) into a video field.
- Paste a JW Player preview URL into a video field.
- Use a legacy `content.jwplatform.com` URL.
- Use a new `cdn.jwplayer.com` URL.
- Render a JW Player video as a responsive iframe.
- Set the player iframe width and height via the formatter.
- Show a cached JW Player poster/thumbnail.
- Add JW Player video through the Video Embed Field WYSIWYG button.
- Use JW Player as a media source (via Video Embed Field media).
- Reference paid, self-branded video hosting from Drupal.
- Embed video without platform branding or recommendations.
- Add a broadcaster's or publisher's hosted video to an article.
- Install a JW Player handler for an existing Video Embed Field setup.
- Enable the provider with no configuration step.
- Extract the media id and player id from a combined JW Player id.
- Display JW Player videos in a view or listing.
- Embed a training or marketing video hosted on JW Platform.
