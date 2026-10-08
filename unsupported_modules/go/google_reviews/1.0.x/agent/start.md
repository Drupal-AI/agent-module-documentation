# Google Reviews — agent index

Project `google_reviews_slider`, machine name **`google_reviews`**. Imports Google Places reviews into
`review` nodes (via cron or a button) and shows them in a Swiper slider block with a global star rating.
No `configure` info key (settings live at `/admin/review-settings`). Provides one permission. No Drush,
no config schema, no plugin types.

- **Settings form, config keys, import (cron + `/reviews`), the review content type & fields, the block,
  the permission** → [configure/settings.md](configure/settings.md)

Key facts:
- Config object `google_reviews.settings`: `google_reviews.api_key`, `google_reviews.place_id`
  (comma+space separated), `minimum_rating`, `max_messages_displayed`, `max_time_displayed` (years),
  `review_title`, `display_rating`, `display_global_rating`, `review_page_link`, `review_page_message`;
  import caches `google_reviews.rating` and `google_reviews.user_ratings_total`.
- Service `google_reviews.reviews_service` (`ReviewService`) → Google Places Details API
  `https://maps.googleapis.com/maps/api/place/details/json`.
- Content type `review` + `field_review_{name,photo_url,language,rating,time,time_description,message}`;
  imported nodes are created **unpublished** (must be published to display).
- Block plugin `reviews_block` (category "Reviews") → `reviews_display_template.html.twig` + Swiper 11
  (jsDelivr CDN).
- Permission `google_reviews admin` gates the settings form and the `/reviews` fetch route.
