<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Embed Iframe — the "Block iframes" filter

## Enable

`drush en cookies_addons_embed_iframe`. Installing the module also installs (config/install):

- `cookies.cookies_service.iframe` — a `cookies_service` entity, id `iframe`, label "Iframes other
  than YouTube", `consentRequired: true`, `group: iframes`, with placeholder text
  ("This content is blocked because Iframe cookies have not been accepted.").
- `cookies.cookies_service_group.iframes` — the "Iframes" group (weight 50).

Then edit a text format at `/admin/config/content/formats/manage/<format>` and enable **Block
iframes**. Order it so it runs after any HTML-restricting filter but before display.

## Filter plugin

`CookiesAddonsEmbedIframeFilter` (`src/Plugin/Filter/CookiesAddonsEmbedIframeFilter.php`):

- Annotation: id `cookies_addons_embed_iframe_filter`, title "Block iframes", `type =
  Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`. Constant `EXTRA_CLASS =
  'cookies-addons-embed-iframe'`.
- `process($text, $langcode)`: `Html::load($text)`; iterate `<iframe>` elements in reverse. For each
  `\DOMElement` with a non-empty `src` where `_cookies_addons_embed_iframe_is_iframe($src)` is TRUE:
  append `EXTRA_CLASS` to `class`, set `src` to `''`, set `data-src` to the original `src`. If any
  matched, `setAttachments(['library' =>
  'cookies_addons_embed_iframe/cookies-addons-embed-iframe'])`. Returns
  `Html::serialize($html_dom)` via `FilterProcessResult`.
- `tips()`: "Converts iframe embed to be cookies restricted."

## Match helper

`_cookies_addons_embed_iframe_is_iframe($src)` (`cookies_addons_embed_iframe.module`) runs
`preg_match_all()` with a negative-lookahead pattern on `htmlspecialchars_decode($src)` and returns
`isset($matches[0][0])` — TRUE when the URL is **not** a YouTube URL (YouTube is handled by the
`cookies_addons_embed_video` submodule instead).

## Client behavior

`js/cookies-addons-embed-iframe.js` (`Drupal.behaviors.cookiesAddonsEmbedIframe`) listens for
`cookiesjsrUserConsent`:

- `consentGiven()`: for each `iframe.cookies-addons-embed-iframe` whose `src` differs from its
  `data-src`, it validates the protocol — a non-root-relative `data-src` must start with `http`/`https`
  (else it is skipped) — then sets `src` = `data-src`.
- `consentDenied()`: applies `cookiesOverlay('iframe')` to
  `iframe.cookies-addons-embed-iframe, div.iframe-embed-lazy`.
- Fires `consentGiven`/`consentDenied` based on `event.detail.services.iframe`.

## Notes

- The filter is transform-irreversible; the stored text is unchanged, only the rendered output has
  `src` relocated to `data-src`.
- No filter settings (schema mapping is empty).
