<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Review adds customer reviews and star ratings to Drupal Commerce products, with one review per user and an auto-computed overall product rating.

---

Logged-in customers write a review (title, body, rating, plus any Field UI extras) at `/product/{id}/add-review`; each authenticated user is limited to exactly one review per product, enforced in the access callback via `loadByProductAndUser()`. Reviews are a revisionable, publishable `commerce_product_review` content entity with configurable `commerce_product_review_type` bundles that can be scoped to specific product types and carry a notification email address. Ratings roll up automatically: a `ProductReviewEventSubscriber` listens on review insert/update/delete and calls `ProductReviewManager::updateOverallRating()`, which averages ratings with the `commerce_price` `Calculator` (3-decimal precision) and writes an `OverallProductRating` value onto the product, rendered as numbers or rateit.js stars via the provided formatters.

The module leans entirely on the `drupal/entity` permission model (`EntityPermissionProvider`), generating per-bundle create/view/update/delete-own/any permissions plus a custom `publish commerce_product_review` and `administer commerce_product_review_type`. Reviews are unpublished by default (admin approval) unless the reviewer's role holds the publish permission. Anonymous visitors hitting the review route are redirected to login (guest reviews are unsupported because one-review-per-user needs an account). A per-review notification email goes to the review-type's configured address on insert via `ProductReviewEmail`. Star display requires the external rateit.js library in `libraries/jquery.rateit/scripts`. Typical setup: install, configure the default review type at `/admin/commerce/config/product-review-types` (enabled product types + notification email), enable the "Overall rating" field on the product display, and tune the entity permissions. All mutating routes are guarded by `_custom_access` callbacks or `_entity_access`.

---

- Let logged-in customers write a review + rating for a product.
- Enforce one review per user per product automatically.
- Show average star rating and review count on product pages.
- Display ratings as numeric values or as rateit.js stars.
- Provide a dedicated per-product reviews page listing all reviews.
- Redirect anonymous visitors to login with a "write a review" invitation.
- Let customers edit or delete their own review.
- Show a customer all their reviews at `/user/{id}/reviews`.
- Hold new reviews unpublished pending admin approval.
- Auto-publish reviews for trusted roles via `publish commerce_product_review`.
- Create multiple review types scoped to specific product types.
- Add custom fields (photos, pros/cons) to a review type via Field UI.
- Customize review form and display modes per review type.
- Email staff a notification when a new review is submitted.
- Configure the notification recipient per review type.
- Bulk publish or unpublish reviews from the admin review list.
- Bulk delete reviews via the delete-multiple route.
- Sort/filter reviews on the product and admin review pages.
- Restrict reviewing to published products only.
- Only expose the review form when a matching review type exists.
- Recalculate a product's overall rating on review add/edit/delete.
- Manage review types (fields/form/display) at the admin page.
- Theme the reviews list and notification email via Twig templates.
- Grant fine-grained per-bundle view/create/update/delete permissions.
