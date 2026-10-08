<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flickr Integration Suite (flickr_integration_suite) — agent index

Integrates Drupal with the Flickr REST API and offers three ways to surface photos, each an
optional submodule. Version **1.0.6**. Core `^10.3 || ^11`. Hard dependency on **`key:key`**.
Configure at `flickr_integration_suite.settings_form`
(`/admin/config/system/flickr-integration-suite`, permission `administer site configuration`).

## Mechanism

- Config object `flickr_integration_suite.settings` holds three keys: `api_endpoint`
  (default `https://api.flickr.com/services/rest/`), `api_key` (the **machine name of a Key
  entity**, not the raw key), and `api_cache_max_age` (seconds, default `86400`).
- The service `flickr_integration_suite.api_provider`
  (`Drupal\flickr_integration_suite\FlickrIntegrationSuiteApiProvider`) is the only thing that
  talks to Flickr. It resolves the Key entity through `key.repository`, sends REST calls as
  Guzzle **GET** requests (built via `http_client_factory`) with the resolved key added as the
  `api_key` query parameter, and caches decoded responses in `cache.default` under
  `flickr_integration_suite:<md5 of sorted params>` for `api_cache_max_age` seconds (0 = no
  cache). See `agent/api/service.md` for the public method signatures and
  `agent/config/settings.md` for the config surface.
- Rendering goes through the `flickr_slider` theme hook / `flickr-slider.html.twig`
  (Swiper-based slider of photos and videos); the filter submodule adds its own
  `flickr_photo` / `flickr_photos` / `flickr_photoset` / `flickr_photo_caption` themes.
- Bundled library: **Swiper 11.1.4** (`assets/swiper-bundle.*`, MIT), attached by the slider.

## Submodules — enable only the placement in use

- `flickr_integration_suite_block` — configurable **blocks** (Flickr Galleries, Flickr Photosets).
- `flickr_integration_suite_field` — **field types** `flickr_galleries` / `flickr_photosets`
  with slider formatters.
- `flickr_integration_suite_filter` — **text-format filter** expanding
  `[flickr-photo:id=…]` / `[flickr-photoset:id=…]` tokens in body text.
- `flickr_integration_suite_filter_colorbox` — nested under the filter; opens filter-embedded
  images in a **Colorbox** lightbox (needs `colorbox`).

## Notes

- **Credential handling is correct** — `key:key` is a hard dependency and the API key is stored
  as a **Key entity** (resolved at runtime), so the secret can live in an environment variable
  and never reaches a config export. Cite this as the pattern other API integrations should
  follow. The key is never logged, echoed to markup, or included in error messages (errors surface
  only the Flickr `method` and `message`).
- TLS verification is left at Guzzle defaults (**enabled**) — no `verify => false`. The endpoint
  is admin-configurable but defaults to HTTPS.
- The Flickr API is rate-limited, so cache rendered output rather than fetching per request; and
  per-image licensing on Flickr varies — displaying a photostream is a rights question the module
  cannot answer.
