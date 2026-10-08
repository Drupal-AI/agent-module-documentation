<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Get URL (get_url) — agent index

**Adds a `get_url()` Twig function that resolves an internal `/segment/digits` path (e.g. `/node/42`) to its URL alias.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10 || ^11 || ^12
- **Service:** `get_url.twig.TwigExtension` (tag `twig.extension`) → `Drupal\get_url\TwigExtension`
- **Twig function:** `get_url(nodeId)` (`is_safe: html`), static `getUrl()` in `src/TwigExtension.php`
- **Routes / permissions / config:** none

**Security:** No server-side URL fetching — no `http_client`/`file_get_contents`/cURL, so **no SSRF**. Input is constrained by regex `^/[a-zA-Z_-]+/\d+$`; aliases that resolve to external URLs are suppressed; output is `Html::escape()`'d before `Markup::create()`. `is_safe: html` returns an escaped internal alias. No anonymous or mutating endpoints.

See [api/twig.md](api/twig.md)
