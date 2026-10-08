# Google Reviews — configuration, import & display

## Settings form

*Configuration → Web services → Review Settings* → `/admin/review-settings`
(route `google_reviews.review_settings`, `_form` `ReviewSettingsForm`, permission `google_reviews admin`,
menu parent `system.admin_config_services`). It is a `ConfigFormBase` editing `google_reviews.settings`.
Its submit button is labelled **"Fetch reviews"** and, after saving, redirects to `/reviews` to run an
import immediately.

### Config keys (`google_reviews.settings`)

| Field | Key | Notes |
|---|---|---|
| API key | `google_reviews.api_key` | Google Places API key (required). |
| Place IDs | `google_reviews.place_id` | One or more, **separated by `", "` (comma + space)** — `array_filter(explode(', ', ...))`. Required. |
| Minimum rating | `google_reviews.minimum_rating` | 0–5 select. Reviews below it are hidden but still count toward the average. |
| Max displayed messages | `google_reviews.max_messages_displayed` | Slice size for the slider (optional). |
| Max review time | `google_reviews.max_time_displayed` | In **years**; older reviews are skipped (optional). |
| Title above block | `google_reviews.review_title` | Optional. |
| Display computed rating | `google_reviews.display_rating` | Show average of imported reviews. |
| Display global rating | `google_reviews.display_global_rating` | Show Google's reported rating + total. |
| Review page link | `google_reviews.review_page_link` | Optional "leave a review" URL. |
| Review page link text | `google_reviews.review_page_message` | Optional link label. |
| (cached by import) | `google_reviews.rating`, `google_reviews.user_ratings_total` | Written by `ReviewService::importReview()` from the API response. |

Validation requires `api_key` and `place_id` non-empty and `minimum_rating` numeric 0–5.

## Import flow

- Service: `google_reviews.reviews_service` (`ReviewService`, arg `@config.factory`).
- `getReviews()` loops the Place IDs and calls the Google Places Details API
  `https://maps.googleapis.com/maps/api/place/details/json` with
  `query = {fields: 'reviews,rating,user_ratings_total', place_id, key}` via `\Drupal::httpClient()`.
- For each returned review not already imported (dedup by node title `"<author_name> : <rating>"`), it
  creates a `review` node with `status = FALSE` (**unpublished**). Publish nodes to make them show.
- Triggers:
  - **Cron** — `google_reviews_cron()` resolves `ReviewController` and calls `fetchReviews()`.
  - **On demand** — route `google_reviews.add_reviews` at `/reviews`
    (`ReviewController::fetchReviews`, permission `google_reviews admin`); the settings form redirects
    here after save.

## Content type & fields (optional config)

Installed from `config/optional/`: content type `review` with fields `field_review_name`,
`field_review_photo_url`, `field_review_language`, `field_review_rating`, `field_review_time` (years,
derived from the relative time string), `field_review_time_description`, `field_review_message`.

## Display block

Block plugin `reviews_block` ("Google reviews content block", category **Reviews**). `build()` loads
published `review` nodes, drops those older than `max_time_displayed` and below `minimum_rating`,
computes the average, and renders theme `reviews_theme`
(`templates/reviews_display_template.html.twig`) — a Swiper 11 carousel of review cards with star icons.
Place it via *Structure → Block layout*. Assets: library `google_reviews/reviews-style` pulls Swiper 11
JS/CSS from the jsDelivr CDN.

## Permission

`google_reviews admin` ("Google reviews module admin") gates both the settings form and the `/reviews`
fetch route. It is a plain (non-`restrict access: true`) permission that only configures the module and
triggers the Google fetch/import — grant it to trusted editors/admins.
