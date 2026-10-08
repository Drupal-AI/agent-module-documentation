<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
**Star Rating** adds an Amazon-style 1-5 star rating widget to content. Visitors click a star (and optionally leave a comment); the vote is saved via AJAX and can be mirrored into a configured [Webform](https://www.drupal.org/project/webform) submission. Blocks and an extra field render the average score, a rating distribution summary, and per-node averages.

---

The widget theme `star_rating` (template `star-rating.html.twig`) posts to route `star_rating.save` (`/star-rating/save`, controller `RatingController::save`). The controller reads `entity_type` (actually the bundle), `entity_id`, `rating` and `comment` from the POST body and `INSERT`s a row into the custom `star_rating` table (`uid`, rating, comment, created) using the query builder; if a Webform is configured it also creates a `WebformSubmission` mapping the configured rating/comment/entity-id elements. Aggregation is done by three blocks — `StarRatingBlock` (the input widget), `StarRatingAverageBlock`, `StarRatingSummaryBlock` (5→1 star distribution percentages) — and a `StarRatingAverageExtraField` display, all reading from the configured Webform's submissions (`webform_id`, `rating_element`, `comment_element`, `entity_id_element` set at `star_rating.settings`, `/admin/config/content/star-rating`, permission *administer site configuration*). `hook_webform_submission_insert/update` invalidate the relevant `node:<nid>` cache tag. `star_rating.save` is gated by the `access content` permission. The stored `comment` is not rendered by any of the shipped blocks/templates.

---

- Add a 1-5 star rating widget to node pages via a block.
- Let visitors submit a rating without a page reload (AJAX).
- Collect an optional free-text comment with each rating.
- Mirror ratings into a Webform for reporting and export.
- Show a node's average star rating in a block.
- Display an Amazon-style rating distribution summary (5→1 stars).
- Render a per-node average via an extra field on the display.
- Configure which Webform elements store rating/comment/entity id.
- Invalidate a node's cache when a new rating arrives.
- Aggregate ratings per content type / bundle.
- Show *No reviews yet* messaging when a node has no ratings.
- Restrict rating configuration to site administrators.
- Style the stars and summary via the shipped CSS/JS libraries.
- Gate the widget block placement by theme region/visibility.
- Collect product or article review scores.
- Export collected ratings through Webform's results tools.
- Compute average and percentage breakdown from Webform submissions.
- Theme the widget and summary through the four provided templates.
