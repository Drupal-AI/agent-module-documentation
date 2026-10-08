<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Cookies Addons Embed Iframe (cookies_addons_embed_iframe) — agent index

Submodule of **Cookies Addons**. A **text-format filter** that gates non-YouTube `<iframe>` embeds
behind the built-in COOKiES `iframe` service. Package COOKiES. Core `^9.2 || ^10 || ^11`. Depends on
`cookies:cookies`. License GPL-2.0-or-later. Version 1.3.3.

- **Filter, regex, JS and install config** → [plugins/filter.md](plugins/filter.md)

## What it provides

- Filter plugin `CookiesAddonsEmbedIframeFilter`
  (`src/Plugin/Filter/CookiesAddonsEmbedIframeFilter.php`) — id `cookies_addons_embed_iframe_filter`,
  title "Block iframes", `type = TYPE_TRANSFORM_IRREVERSIBLE`. `process()` uses `Html::load()` +
  `getElementsByTagName('iframe')`, and for each iframe whose `src` matches
  `_cookies_addons_embed_iframe_is_iframe()` sets `src=''`, `data-src=<orig>`, adds class
  `cookies-addons-embed-iframe`; attaches the JS library when any matched.
- Helper `_cookies_addons_embed_iframe_is_iframe($src)` (`cookies_addons_embed_iframe.module`) — regex
  returning TRUE for non-YouTube URLs (negative-lookahead against youtu.be / youtube(-nocookie).com).
- Library `cookies_addons_embed_iframe/cookies-addons-embed-iframe`
  (`js/cookies-addons-embed-iframe.js`) — on consent restores `data-src`→`src` (only `http`/`https`
  or root-relative), else `cookiesOverlay('iframe')`.
- Config schema `filter.settings.cookies_addons_embed_iframe_filter` (empty mapping — no filter
  settings).
- Config install: `cookies.cookies_service.iframe` (service id `iframe`, "Iframes other than
  YouTube", `consentRequired: true`, group `iframes`) and `cookies.cookies_service_group.iframes`
  ("Iframes" group).
- No routes, permissions, services, controllers, Drush.

Privacy/consent gate. The filter only relocates the author-supplied `src` to `data-src`; it does not
inject or emit new markup.
