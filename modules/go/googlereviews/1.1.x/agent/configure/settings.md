<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Google Reviews

Settings UI: `/admin/config/system/googlereviews` (route `googlereviews.settings_form`,
`SettingsForm`), permission **`administer googlereviews configuration`**. Config object:
**`googlereviews.settings`**.

## Global settings

| Key | Default | Meaning |
|---|---|---|
| `google_places_api` | `0` | API version: `0` = legacy Places API, `1` = new Places API v1 (changes how auth/URL are built). |
| `google_api_url` | `https://maps.googleapis.com/maps/api/place/details/json` | Base request URL. For v1 the place ID is appended to this URL; for legacy it is used as-is with query params. |
| `google_auth_key` | (unset) | Google API key. Legacy: sent as `?key=`. v1: sent as `X-Goog-Api-Key` header. |
| `google_place_id` | (unset) | Default Google Place ID used when a block doesn't override it. |
| `cache_max_age` | `86400` | Cache lifetime (seconds) for block output. |

If `google_auth_key` or the resolved place ID is empty, blocks render nothing and an admin
error message links back to this form.

## Legacy vs v1 request (`GetGoogleData::getGoogleReviews`)

- **Legacy (`google_places_api` != 1):** GET `google_api_url` with query
  `place_id`, `key`, `language`, `fields`, `reviews_sort`. Reads `result.reviews`,
  `result.rating`, etc.
- **v1 (`google_places_api` === 1):** GET `google_api_url . place_id` with headers
  `X-Goog-Api-Key`, `languageCode`, `X-Goog-FieldMask` (comma-joined fields), `Content-Type`.
  Maps v1 shapes (`authorAttribution.displayName`, `text.text`, `userRatingCount`,
  `googleMapsLinks.reviewsUri`, …) back to the internal review array.

Note: the version comparison is strict (`=== 1`); the setting is stored as an integer via the
config schema.

## Blocks (place via Block layout / Layout Builder)

### `googlereviews_reviews` — "Google Reviews List"
Config: `max_google_reviews` (1–5, default 5), `google_reviews_sorting`
(`newest` | `most_relevant`), `google_place_id` (override), and under **Moderation settings**:
`minimum_google_rating` (hide reviews below this rating) and
`filtered_google_review_words` (comma-separated; hides a review if any word matches the review
text or reviewer name — see `GetGoogleData::filterReviews`). Renders
`#theme googlereviews_reviews_block` with library `googlereviews/googlereviews.reviews`.

### `googlereviews_rating` — "Google Reviews Rating"
Config: `google_place_id` (override) only. Renders aggregate rating, `rating_percentage`
(`rating/5*100`), total count, and a link to the place, via
`#theme googlereviews_rating_block` + library `googlereviews/googlereviews.rating`.

Both blocks return `getCacheMaxAge()` from config, so cached output respects `cache_max_age`.

## Templates

Override `googlereviews-reviews-block.html.twig` and `googlereviews-rating-block.html.twig`
in your theme to restyle. Review values (author, text, rating) are passed as variables and
Twig auto-escapes them.
