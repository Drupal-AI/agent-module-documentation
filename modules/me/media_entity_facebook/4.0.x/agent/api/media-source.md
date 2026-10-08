<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — media source, fetcher, formatter

## Source plugin — `Facebook` (`@MediaSource id="facebook"`)

`src/Plugin/media/Source/Facebook.php`, extends `MediaSourceBase`, implements `MediaSourceFieldConstraintsInterface`.

- `allowed_field_types = {"string_long"}`, `default_thumbnail_filename = "facebook.png"`.
- `getMetadataAttributes()` → `author_name`, `width`, `height`, `url`, `html`.
- `getMetadata($media, $attr)` resolves the content URL via `getFacebookUrl()` then calls `FacebookFetcher::getOembedData()`; returns the requested attribute (or `parent` for unknowns). Returns FALSE on any failure.
- `getSourceFieldConstraints()` → `['FacebookEmbedCode' => []]`.

### URL parsing — `Facebook::parseFacebookEmbedField($data)` (static, reusable)

1. If `$data` matches `^https://(www\.)?facebook\.com/` → return as-is.
2. Else if it matches `^https://(www\.)?fb\.watch/` → return as-is.
3. Else parse `$data` as HTML (`DOMDocument`), take the first `<iframe src>`, `parse_url` its query, and return `href` if that matches the facebook.com regex.
4. Otherwise return FALSE (constraint then flags the field invalid).

## Fetcher — `media_entity_facebook.facebook_fetcher`

`FacebookFetcher::getOembedData($resource_url)`:

- **Embedded Posts mode** (`use_embedded_posts` truthy, default): no HTTP call. Returns a render array `#theme => 'media_entity_facebook'` with `#url => $resource_url`, `#is_iframe`, `#fb_sdk_langcode`, plus fixed `author_name='Facebook'`, `width='500'`, `height='auto'`.
- **oEmbed API mode**: builds `getApiEndpointUrl($resource_url) . '?url=' . $resource_url . '&access_token=' . $appId . '|' . $appSecret . '&sdklocale=' . $fbLangcode`. Endpoint is `graph.facebook.com/v11.0/oembed_video` for `/videos/`, `/video.php/`, or `fb.watch` URLs, else `oembed_post`. Guzzle GET, 5s timeout; result cached in `cache.default` under `media_entity_facebook:<hash>` for 600s. On Guzzle error it logs, sets an internal flag, and aborts further requests in the same page build.
- Interface language is mapped to a Facebook locale via the `$langcodes` table (fallback `en_US`).

The endpoint host is fixed to `graph.facebook.com` and the URL is constraint-limited to facebook domains, so this is not a general SSRF sink.

## Formatter — `facebook_embed`

`FacebookEmbedFormatter` (field types `link`, `string`, `string_long`; `isApplicable` only on `media` entities). For each item it merges the source's `html` metadata (the render array above) with the media entity's cache contexts/tags/max-age.

## Output & XSS responsibility

`templates/media-entity-facebook.html.twig` renders **raw markup**:

- `is_iframe` branch: `{{ url|raw }}` — outputs the URL/markup unescaped.
- default (SDK) branch: injects the Facebook SDK `<script>` and a `fb-post` div with `data-href="{{ url }}"` (escaped) plus a small inline `<script>`.

In practice the `url` reaching the template is the parsed facebook.com content URL (the constraint + `parseFacebookEmbedField()` reduce arbitrary input to a facebook-domain URL), and `is_iframe` is only true when the resolved value literally contains `<iframe` — which the parser normally strips. Still, this is **by-design raw HTML output that trusts a facebook-domain-constrained string**: only grant Facebook-media create/edit permissions to trusted editors, keep the `FacebookEmbedCode` constraint in place, and be aware the SDK/`|raw` path deliberately emits unescaped markup. Do not remove the constraint or feed the source field unvalidated user input.
