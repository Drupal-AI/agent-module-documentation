<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Google Reviews Slider (machine name `google_reviews`) pulls a business's Google reviews from the Google Places Details API and displays them, with the aggregate rating, in a Swiper.js slider block.

---

The module imports reviews for one or more Google Place IDs as unpublished `review` nodes so an editor can moderate them before they show. A single settings form (`/admin/review-settings`, permission `google_reviews admin`) holds the API key, Place IDs, a minimum rating, message/age caps, a title, whether to show the computed and Google-reported ratings, and an optional "leave a review" link. Fetching happens on cron, when the settings form is saved, or by visiting `/reviews`. The `reviews_block` block renders published reviews — message text, author name and photo, star rating, and relative time — as a carousel using the bundled Swiper 11 library loaded from a CDN.

---

- Show Google reviews on the site.
- Display customer reviews in a slider/carousel.
- Add social proof or testimonials to a landing page.
- Pull reviews for a single Google Place ID.
- Aggregate reviews from multiple Place IDs into one block.
- Show star ratings per review.
- Display the average rating of imported reviews.
- Display Google's overall rating and total review count.
- Hide reviews below a minimum star rating.
- Cap how many review messages the slider shows.
- Drop reviews older than a set number of years.
- Import reviews as unpublished nodes for moderation.
- Publish or unpublish individual reviews before display.
- Add a title above the reviews block.
- Add a "leave a review" call-to-action link.
- Refresh reviews automatically on cron.
- Trigger an on-demand review fetch from `/reviews`.
- Restrict review administration to a single permission.
- Style the reviews slider via the bundled CSS.
- Show reviewer profile photos alongside messages.
- Surface recent Google ratings for a business.
- Add trust signals to a marketing page.
- Rotate testimonials in a looping carousel.
- Store the fetched aggregate rating in config.
- Connect a business by its Google Place ID.
