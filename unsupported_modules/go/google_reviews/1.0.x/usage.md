Google Reviews (project `google_reviews_slider`, machine name `google_reviews`) imports Google Places reviews into Drupal as `review` nodes and displays them in a Swiper-based slider block with a global star rating.

---

Configured at *Configuration → Web services → Review Settings* (`/admin/review-settings`, gated by the `google_reviews admin` permission), where you enter a Google Places **API key** and one or more comma-separated **Place IDs**, plus display options (minimum rating to show, max messages, max review age in years, block title, whether to show the computed and/or Google-reported global rating, and an optional "leave a review" link). `ReviewService::getReviews()` calls the Google Places Details API (`https://maps.googleapis.com/maps/api/place/details/json` with `fields=reviews,rating,user_ratings_total`) for each Place ID and creates one **unpublished** `review` node per new review (deduplicated by title `"<author> : <rating>"`), storing author name, photo URL, language, rating, relative time, and message in `field_review_*` fields; it also caches the place's overall rating and total review count into `google_reviews.settings`. Imports run on **cron** (`hook_cron` calls the same controller) and on demand via the "Fetch reviews" button (which redirects to `/reviews`, also permission-gated). Imported reviews arrive unpublished, so an editor must publish the ones to show. The `reviews_block` block (category "Reviews") loads published `review` nodes, filters by the configured minimum rating and max age, computes an average, and renders `reviews_display_template.html.twig` using the bundled Swiper 11 library (loaded from jsDelivr CDN) as a carousel with star icons. The review content type and its fields are installed as optional config; Swiper JS/CSS come from a CDN (no PHP library dependency).

---

- Show recent Google reviews for your business in a slider/carousel block on the site.
- Display an overall Google star rating and total review count as social proof.
- Import reviews from a single Google Place (business location) by Place ID.
- Aggregate reviews from multiple locations by listing several comma-separated Place IDs.
- Automatically refresh reviews on cron without manual work.
- Manually pull the latest reviews on demand with the "Fetch reviews" button.
- Moderate which reviews appear by publishing the imported (unpublished) `review` nodes.
- Hide low-rated reviews from display with a minimum-rating threshold (while still counting them in the average).
- Limit how many review messages the slider shows at once.
- Drop reviews older than a configured number of years from the display.
- Add a custom title above the reviews block.
- Show a computed average rating from imported reviews, the Google-reported global rating, or both.
- Add a "Leave us a review" call-to-action link with custom text under the slider.
- Store each Google review as an editable Drupal node (`review` content type) for reuse elsewhere.
- Build a testimonials section powered by real Google reviews.
- Reuse the imported review fields (`field_review_name`, `field_review_rating`, etc.) in custom Views or displays.
- Place the reviews block in any theme region via Block Layout.
- Integrate a Drupal site with an existing Google Cloud Places API key.
