<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Infogram graphs integrates Infogram interactive charts and infographics into Drupal, both as a media oEmbed source (for `infogram.com/*` URLs) and as a WYSIWYG text-format filter that turns an `[infogram id="..." format="..."]` shortcode into an embed container.

---

The module implements `hook_media_source_info_alter()` to register an `infogram` oEmbed media source (using core's `OEmbed` source and media-library oEmbed form) and `hook_oembed_resource_data_alter()` to fill in missing thumbnail dimensions by fetching the provider thumbnail via the Drupal HTTP client. The `FilterInfogram` filter parses the shortcode and calls the `Infogram` service, which renders `templates/infogram.html.twig` — a `<div class="infogram-embed" data-id="…" data-type="…">` plus the Infogram embed-loader library.

This is a content-display/embedding feature. The embed template outputs the id/format into quoted, Twig-autoescaped `data-` attributes, so shortcode values are escaped. The thumbnail fetch uses the default (TLS-verified) HTTP client against the Infogram oEmbed provider only; core oEmbed provider allow-listing applies. No security findings; use the filter only in text formats granted to trusted roles as with any embed filter.

---

- Embed Infogram interactive graphs in content.
- Display infographics and data visualizations.
- Register Infogram as an oEmbed media source.
- Add Infogram media via the media library.
- Use `infogram.com/*` URLs as media.
- Insert charts with an `[infogram ...]` WYSIWYG shortcode.
- Render embeds through a Twig template + embed loader.
- Fill in missing oEmbed thumbnail dimensions.
- Provide thumbnails for Infogram media entities.
- Reuse core Media and oEmbed infrastructure.
- Keep embed markup minimal (a data-id container).
- Configure the filter per text format.
- Show responsive Infogram embeds.
- Present charts without manual iframe code.
- Support interactive and other Infogram formats.
- Integrate data storytelling into pages.
