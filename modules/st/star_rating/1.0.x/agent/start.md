<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Star Rating (star_rating) — agent index

Amazon-style 1-5 **star rating** widget for nodes; saves to a custom `star_rating` table and optionally a Webform. Version **1.0.0**, core `^10`. No hard dependency, but Webform integration and `hook_webform_submission_*` assume `drupal/webform`.

**Shape:** widget block `StarRatingBlock` (template `star-rating.html.twig`, JS posts to `/star-rating/save`). Controller `RatingController::save` → parameterized `INSERT` into `star_rating` + optional `WebformSubmission`. Summary/average via `StarRatingAverageBlock`, `StarRatingSummaryBlock`, `StarRatingAverageExtraField`, all reading Webform submissions. Config `star_rating.settings` at `/admin/config/content/star-rating` (*administer site configuration*).

**Access:** route `star_rating.save` requires **`access content`**. `comment` is stored but not rendered by the shipped blocks/templates.
