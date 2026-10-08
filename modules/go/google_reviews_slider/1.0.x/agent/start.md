<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Google Reviews Slider (google_reviews) — agent index

Machine name **`google_reviews`** (project `google_reviews_slider`). Fetches a
business's Google reviews from the Google Places **Details** API, imports each as an
**unpublished `review` node**, and renders a global rating plus review messages in a
Swiper.js **slider block** (`reviews_block`). Import runs on cron, when the settings
form is saved, and by visiting `/reviews`.

- **Dependencies:** none declared in `info.yml`; functionally relies on core `node`
  and `block` (and `menu_ui` for the optional `review` node type shipped in
  `config/optional`). Core `^9 || ^10 || ^11`.
- **Settings page:** route `google_reviews.review_settings` at `/admin/review-settings`
  (menu link under Configuration ▸ Web services). Note: `info.yml` has **no** `configure:`
  key, so there is no "Configure" link on the Extend page.
- Defines **1 permission** (`google_reviews admin`); **no** Drush commands, **no**
  plugin types it defines, **no** config schema.

Solution docs:
- **Set the API key, Place IDs and display options** → [configure/settings.md](configure/settings.md)
- **Restrict who can administer / trigger a fetch** → [permissions/permissions.md](permissions/permissions.md)
- **Place and understand the reviews slider block** → [blocks/reviews-block.md](blocks/reviews-block.md)
- **Fetch/import flow, the ReviewService API, cron, and the `review` content type** → [api/review-service.md](api/review-service.md)

Key facts (real machine names):
- Config object: `google_reviews.settings`. Every key is nested under a
  `google_reviews.` prefix, e.g. `google_reviews.api_key`, `google_reviews.place_id`.
- Service: `google_reviews.reviews_service` → `Drupal\google_reviews\ReviewService`
  (constructor arg `@config.factory`).
- Routes: `google_reviews.review_settings` (`/admin/review-settings`, form
  `ReviewSettingsForm`), `google_reviews.add_reviews` (`/reviews`, controller
  `ReviewController::fetchReviews`). Both require permission `google_reviews admin`.
- Block plugin id: `reviews_block` (class `ReviewsBlock`, admin label "Google reviews
  content block", category "Reviews").
- Theme hook: `reviews_theme` (template `reviews_display_template.html.twig`).
- Libraries: `google_reviews/swiperjs`, `google_reviews/swiper`,
  `google_reviews/reviews-style` (Swiper 11 JS/CSS from the jsDelivr CDN).
- Content type: `review` (fields `field_review_name`, `field_review_message`,
  `field_review_rating`, `field_review_time`, `field_review_time_description`,
  `field_review_photo_url`, `field_review_language`).
- Permission: `google_reviews admin`.
- Cron hook: `google_reviews_cron()` (calls `ReviewController::fetchReviews()`).
