<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bitly Shortener (bitly_shortener) — agent index

Integrates a Drupal site with the **Bitly** URL-shortening service. Core `^9 || ^10 || ^11`,
license GPL-2.0-or-later, version 2.1.4. **No contrib dependencies** (core only). Package: none
(top-level). Provides **no permissions**, **no Drush**, **no plugin types**; ships config schema.

## What it provides

- **Service `bitly_shortener`** — `BitlyShortenerServices::shortener($url)` POSTs `{long_url}` to
  the Bitly v4 bitlinks endpoint with `Authorization: Bearer <token>` and returns the `link`.
- **Twig function `bitly_shortener()`** — `BitlyShortenerTwigServices` (a `twig.extension`) wraps
  the service: `{{ bitly_shortener('https://…') }}`.
- **Block `bitly_shortener_block`** (*Bitly Shortener*) — `BitlyShortenerBlock` shortens the
  **current page URL** (`Url::fromRoute('<current>')`) and themes it with a copy-to-clipboard button.
- **Settings form** at `/admin/config/bitly-shortener/api` (route
  `bitly_shortener:bitly_shortener_settings`, permission `administer site configuration`).
- **Config object `bitly_shortener.settings`**: `bitly_shortener_enable`, `bitly_shortener_api`,
  `bitly_shortener_token`.

## Solution docs

- **Service + Twig function + block, method by method** → [api/service.md](api/service.md)
- **Settings form, config object, schema, routes/permissions** → [config/settings.md](config/settings.md)

## Notes

- The Twig function and block make an **external Bitly API call at render time** — cache results
  and mind Bitly rate limits (the block sets `getCacheMaxAge() = 0`, so it re-calls per request).
- Uses Drupal's HTTP client (`\Drupal::httpClient()`) with **default TLS verification** (no
  `verify` override). The access token is a credential; keep it out of committed config.
