<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Reviews — agent index

Shows Google reviews and aggregate rating in Drupal blocks, fetched from the Google Places
API. Two block plugins + one fetch service. Config UI at
`/admin/config/system/googlereviews` (route `googlereviews.settings_form`).

- **Settings keys, legacy vs v1 Places API, the two blocks and their config, cache max-age,
  the admin permission, templates** → [configure/settings.md](configure/settings.md)
- **The `GetGoogleData` service for programmatic fetches** → [api/service.md](api/service.md)

Key facts:
- Config object `googlereviews.settings`: `google_places_api` (0=legacy, 1=v1),
  `google_api_url` (default `https://maps.googleapis.com/maps/api/place/details/json`),
  `google_auth_key`, `google_place_id`, `cache_max_age` (default 86400).
- Blocks: `googlereviews_reviews` (list, with moderation settings) and `googlereviews_rating`
  (aggregate). Both accept a per-block `google_place_id` override.
- Permission: `administer googlereviews configuration` (gates only the settings form).
- Templates: `googlereviews-reviews-block.html.twig`, `googlereviews-rating-block.html.twig`.
- Fetch host is admin config with a fixed Google default; not user-supplied (no SSRF).
