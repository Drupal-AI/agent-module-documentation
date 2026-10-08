# Block — reviews_block (Google reviews slider)

Plugin `Drupal\google_reviews\Plugin\Block\ReviewsBlock` (extends `BlockBase`).

```
@Block(
  id = "reviews_block",
  admin_label = @Translation("Google reviews content block"),
  category = @Translation("Reviews"),
  provider = "google_reviews",
)
```

Place it at **Structure ▸ Block Layout** ("Google reviews content block", category
"Reviews"). It has **no per-block config form** — every display option comes from the
global `google_reviews.settings` config (see `../configure/settings.md`).

## What `build()` does

1. Reads display options from `google_reviews.settings` (`review_title`,
   `display_rating`, `display_global_rating`, `review_page_link`,
   `review_page_message`, `minimum_rating`, `max_messages_displayed`,
   `max_time_displayed`).
2. Loads **published** `review` nodes: `getReviewsContent()` does
   `entityTypeManager()->getStorage('node')->loadByProperties(['type' => 'review', 'status' => 1])`.
   If none, returns `#markup` "No reviews to display".
3. For each review node it reads `field_review_rating` and `field_review_time`, then:
   - skips it if `max_time_displayed` is set and the review is older;
   - adds its rating to a running total (regardless of `minimum_rating`);
   - if `rating >= minimum_rating`, appends a message (name, photo URL, rating, relative
     time text, message text) to the display list.
4. `display_rating` → `#rating` = `round(total / count, 1)` (average of retrieved
   reviews). `display_global_rating` → `#global_rating` / `#total_reviews` from the
   fetched `google_reviews.rating` / `google_reviews.user_ratings_total` config.
5. `max_messages_displayed` slices the message list. Returns a render array themed with
   `#theme => 'reviews_theme'`.

## Theme + template

`hook_theme()` (`google_reviews.module`) defines **`reviews_theme`** → template
`reviews_display_template.html.twig`, with variables: `rating`, `global_rating`,
`total_reviews`, `messages` (each: `message`, `author_photo_url`, `author_name`,
`author_rating`, `time`), `title`, `review_link_url`, `reviews_link_text`.

The template renders: optional title, a color-coded global-rating circle (green ≥3.5,
red <2, yellow otherwise), the fetched global rating line, then a `.swiper` carousel with
one `.swiper-slide` per message (message text truncated to 400 chars, author photo,
author name in `<strong>`, a star SVG repeated `author_rating` times, relative time), and
a trailing "leave a review" link.

## Slider libraries

Attached via the template's `{{ attach_library('google_reviews/reviews-style') }}`
(`google_reviews.libraries.yml`):

- `reviews-style` → `assets/css/style.css` + Swiper 11 CSS; depends on `swiper`.
- `swiper` → `assets/js/review_swiper.js`; depends on `swiperjs`.
- `swiperjs` → Swiper 11.1.1 bundle loaded **externally from the jsDelivr CDN**
  (`https://cdn.jsdelivr.net/npm/swiper@11/...`).

`review_swiper.js` initializes `new Swiper('.swiper', { loop: true, navigation: { nextEl:
'.swiper-button-next', prevEl: '.swiper-button-prev' } })`.

## Quirks worth knowing

- Reviews imported from Google are created **unpublished**; the block shows only
  `status = 1` nodes, so an editor must publish them before they appear.
- The template reads `review_page_link` / `reviews_link_message`, but the theme hook and
  block pass `review_link_url` / `reviews_link_text` — the variable names don't line up,
  so the trailing "leave a review" link href/text render empty in stock 1.0.2.
- The block sets no custom cache tags/contexts, so it inherits `BlockBase` defaults;
  newly published reviews may not appear until caches are cleared.
