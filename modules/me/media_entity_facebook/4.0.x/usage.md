<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Media Entity Facebook adds a `facebook` media source to Drupal core Media, letting editors create Media entities from Facebook post/photo/video URLs (or iframe embed codes) and render them on the site.

---

The module defines a `MediaSource` plugin (`facebook`) whose source field is a `string_long` field holding a Facebook content URL or an iframe embed snippet. A `FacebookEmbedCode` validation constraint enforces that the value resolves to a `facebook.com`/`fb.watch` URL — `Facebook::parseFacebookEmbedField()` accepts a raw facebook URL or extracts the `href` from a pasted `<iframe>` embed. Rendering is done by the `facebook_embed` field formatter, which asks the source for the `html` metadata attribute; that comes from `FacebookFetcher`, which has two modes controlled by the `use_embedded_posts` setting. In **Embedded Posts** mode (the default, no API review needed) it renders the Facebook JavaScript SDK (`connect.facebook.net/<locale>/sdk.js`) plus a `fb-post` div pointing at the URL. In **oEmbed API** mode it calls `https://graph.facebook.com/v11.0/oembed_post` (or `oembed_video` for video URLs) using a `facebook_app_id|facebook_app_secret` access token, caching each response for 10 minutes; this mode requires a reviewed Facebook app. Settings live at `/admin/config/media/facebook-settings` (`administer media` permission; note `configure` is not declared in info.yml). The current interface language is mapped to a Facebook SDK locale. A `media_library_add` form lets editors add Facebook media directly inside the Media Library. Themers can override `templates/media-entity-facebook.html.twig`.

---

- Add a "Facebook" media type backed by the `facebook` source so editors can embed Facebook posts.
- Let editors paste a Facebook post URL and have it render as an embedded post.
- Accept a Facebook `<iframe>` embed code and automatically extract the post URL from it.
- Embed Facebook photos on content pages via the Media system.
- Embed Facebook videos (routes to the `oembed_video` endpoint) when using the API mode.
- Use the default Embedded Posts (SDK) mode to embed content without a Facebook app review.
- Switch to the oEmbed Graph API mode with an app ID/secret for server-side embed HTML.
- Add Facebook media from within the core Media Library modal (`media_library_add` form).
- Validate that only genuine facebook.com / fb.watch URLs are accepted as media.
- Localize the Facebook SDK to the site's current interface language.
- Cache oEmbed API responses for 10 minutes to reduce outbound requests.
- Expose Facebook metadata attributes (author name, width, height, URL, HTML) for mapping to media fields.
- Reuse a single Facebook media entity across many nodes/pages.
- Present Facebook embeds through core Media view modes and displays.
- Theme the embed markup by overriding `media-entity-facebook.html.twig`.
- Provide a fallback placeholder in CKEditor so embeds don't render as empty squares while the SDK loads.
- Build a social wall or news feed of curated Facebook posts as Media entities.
- Standardize how Facebook content is embedded site-wide instead of pasting raw embed codes into the body.
