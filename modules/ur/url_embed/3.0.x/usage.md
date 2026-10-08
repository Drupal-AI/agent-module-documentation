<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
URL Embed lets editors paste a plain URL (YouTube, Twitter/X, Instagram, a news article, etc.) into a CKEditor 5 text field and have it render as rich embedded content, using oEmbed/Open Graph data fetched by the `oscarotero/embed` PHP library.

---

The module ships two text filter plugins built on top of the `embed` module's `<drupal-url>` tag convention: `url_embed_convert_links` rewrites bare URLs typed in the body into `<drupal-url data-embed-url="...">` elements, and `url_embed` renders any `<drupal-url data-embed-url="...">` element already present into the provider's embed HTML (oEmbed iframe, Open Graph card, etc.), optionally wrapped in a responsive container. A CKEditor 5 plugin (toolbar button `urlembed`, plugin class `Drupal\url_embed\Plugin\CKEditor5Plugin\UrlEmbed`) adds a dialog for pasting a URL directly, backed by the `embed.button.url` Embed Button config entity and the `url` `EmbedType` plugin; the dialog route is protected by a custom access check that requires the toolbar to actually contain the `urlembed` button. Outside of text formats, the `url_embed` field formatter (`LinkEmbedFormatter`) renders any Link field as an embed the same way. All embed fetching goes through the `url_embed` service (`Drupal\url_embed\UrlEmbed`), which wraps `Embed\Embed::get()`; `hook_url_embed_options_alter()` lets other modules rewrite the URL or adapter options per request. A settings form at Configuration > Media > Url Embed (`url_embed.admin`) stores a Facebook/Instagram app ID and secret in `url_embed.settings`, which the service turns into an oEmbed access token for those two providers. The module requires the `embed/embed` (`oscarotero/embed`) Composer library and will fail its install/runtime requirements check if that class is missing.

---

- Let editors embed a YouTube or Vimeo video by pasting its URL into a rich text field.
- Auto-convert a bare URL typed into body text into a rendered embed via `url_embed_convert_links`.
- Add the "Url Embed" (`urlembed`) button to a CKEditor 5 toolbar so editors can paste a URL through a dialog instead of typing markup.
- Render a `<drupal-url data-embed-url="...">` tag already present in stored HTML using the `url_embed` filter.
- Embed a tweet/X post, Instagram post, or Facebook post using oEmbed.
- Show a rich Open Graph preview card for a plain article link that has no oEmbed endpoint.
- Configure a Facebook App ID/App Secret so Facebook and Instagram oEmbed requests are authenticated.
- Wrap embeds in a responsive container so iframes scale to the width of the content area.
- Set a fallback aspect ratio for embeds whose provider does not report one.
- Use the `url_embed` Link field formatter to render a plain Link field's value as a rich embed instead of a hyperlink.
- Allow editors to embed a URL via the CKEditor 5 dialog and preview it before saving.
- Programmatically fetch oEmbed/Open Graph data for a URL from custom code via the `url_embed` service.
- Alter the URL or oEmbed request options for a specific domain (e.g. force a max height on Twitter embeds) via `hook_url_embed_options_alter()`.
- Restrict who can change the Facebook app credentials with the `administer url_embed` permission.
- Limit which URLs get auto-converted to embeds by setting a required URL prefix on `url_embed_convert_links`.
- Style the CKEditor 5 preview iframe using the module's `ckeditor5-stylesheets` info.yml declaration.
- Add the URL embed type to a custom Embed Button so a different toolbar button label/icon can be used.
- Debug an invalid Facebook App ID/Secret pair via the admin form's live token-validity check.
- Show a placeholder icon for the URL embed type in the CKEditor 5 embed browser.
- Combine `url_embed_convert_links` and `url_embed` on the same text format so authors can just paste raw links.
- Prevent unsupported or unreachable URLs from being converted (the filter silently leaves the original text if no embeddable content is found).
- Reuse the module's `responsive_embed` theme hook / `responsive-embed.html.twig` template for custom embed rendering.
- Log fetch failures (bad URL, network error) to the `url_embed` logger channel instead of breaking the page.
- Ship a text format via configuration export with `url_embed` and `url_embed_convert_links` pre-enabled for a new site build.
- Require the `embed/embed` PHP library as an install-time dependency check before the module can be enabled.
- Give content editors a no-code way to embed rich social/media content without granting HTML markup access.
