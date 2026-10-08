<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Client Options per URI (http_client_options_per_uri) — agent index

**Replaces `http_client_factory` with a factory that merges per-URI Guzzle options (from a settings.php regexp map) into every outgoing request via middleware.**

- **Version:** 1.1.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Service override:** `http_client_factory` → `HcopuClientFactory` (`http_client_options_per_uri.services.yml`)
- **Mechanism:** Guzzle middleware unshifted in `fromOptions()`; `requestOptionsUriLocate()` reads `$settings['http_client_options_per_uri_config']` = array of `{regexp, options}`; matched options merged with `NestedArray::mergeDeep` (last match wins)
- **UI / routes / permissions / config entities:** none — configured only in `settings.php`

**Security:** Options are merged verbatim, so `verify => false` (disable TLS verification per host) and other sensitive Guzzle options **can** be set — but only via `settings.php` (root/deploy-trusted), with no admin UI or config-entity exposure and no reachable path for a site admin or anonymous user to change them. Treat any `verify => false` entry as an intentional, auditable operator choice. No anonymous or mutating endpoints.

See [configure/settings.md](configure/settings.md)
