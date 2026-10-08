<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Displays a business's Google reviews and overall Google star rating in Drupal blocks, fetched from the Google Places API using a place ID and API key.

---

Google Reviews provides two block plugins — **Google Reviews List** (`googlereviews_reviews`) and **Google Reviews Rating** (`googlereviews_rating`) — that render review cards and an aggregate rating for a Google place. A single `GetGoogleData` service performs the outbound HTTP request (Drupal `http_client`) to the Google Places API, supporting both the legacy Places API (`place/details/json`, key + place_id as query params, `reviews_sort` newest/most_relevant) and the newer Places API v1 (place id appended to the URL, `X-Goog-Api-Key` / `X-Goog-FieldMask` headers). Global settings at `/admin/config/system/googlereviews` (`googlereviews.settings`) hold the API version toggle, the API base URL, the Google auth key, a default place ID, and a cache max-age. Each block can override the place ID, and the reviews block adds moderation options: a maximum number of reviews (1–5), minimum rating threshold, comma-separated filter words that hide matching review text or reviewer names, and a sort order. Results honor the configured cache max-age (default 24h) via the block's `getCacheMaxAge()`. Output is themed through `googlereviews-reviews-block.html.twig` / `googlereviews-rating-block.html.twig` (Twig auto-escaped). The API URL is admin configuration with a fixed default of `https://maps.googleapis.com/maps/api/place/details/json`; there is no user-supplied host.

---

- Show recent Google reviews for your business location in a sidebar or footer block.
- Display your aggregate Google star rating and total review count as a badge.
- Place separate reviews and rating blocks on different pages via Block layout.
- Pull reviews for a specific location by Google Place ID.
- Show reviews for multiple locations by placing multiple blocks with different place IDs.
- Limit how many reviews a block shows (1–5).
- Hide low-star reviews by setting a minimum rating threshold on the reviews block.
- Filter out reviews containing specific words in the text or the reviewer's name.
- Sort reviews by newest or Google's "most relevant" (legacy API).
- Use the newer Google Places API v1 (header-auth, field masks) instead of the legacy API.
- Keep using the legacy Places API details endpoint if that's what your key supports.
- Point the module at a custom/proxy Google Places API URL via config.
- Cache Google API responses (default 24h) to stay within Places API quota.
- Restrict who can configure the integration with the module's admin permission.
- Link each review/rating back to the location's Google Maps reviews page.
- Localize the review request to the current interface language automatically.
- Surface social-proof/testimonials on a marketing or landing page.
- Show star ratings on a "Contact"/"About" page to build trust.
- Programmatically fetch reviews in custom code via the `googlereviews.get_google_data` service.
- Theme the review cards or rating markup by overriding the module's Twig templates.
