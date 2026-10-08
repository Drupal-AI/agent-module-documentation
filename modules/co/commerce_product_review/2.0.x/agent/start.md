<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Product Review (commerce_product_review) — agent index

**Customer reviews + star ratings for Drupal Commerce products, one review per user, with an auto-computed overall product rating.**

- **Version:** 2.0.x
- **Core:** `^10.3 || ^11`
- **Dependencies:** `commerce:commerce_price`, `commerce:commerce_product`

Key surfaces:
- Content entity `commerce_product_review` (revisionable, publishable) with `commerce_product_review_type` bundles.
- Routes: `/product/{p}/add-review`, `/edit-review`, `/delete-review`, `/login-to-review`, `/product/{p}/reviews`, `/user/{user}/reviews`, admin list `/admin/commerce/product-reviews`.
- Services: `..product_review_manager` (rating aggregation), `..product_review_email` (notifications), `..product_review_subscriber` (recompute + email on CUD).
- Permissions: `administer commerce_product_review_type`, `publish commerce_product_review`, plus the entity-API per-bundle set.
- rateit.js library required for star widgets/formatters.

See [configure/commerce_product_review.md](configure/commerce_product_review.md) for routes, permissions, review-type setup, and rating aggregation.

**Security:** No findings. Add/edit/delete-review routes use `_custom_access` callbacks checking product-published state, authentication, one-review ownership, and the entity access handler; the reviews list requires `_entity_access: commerce_product.view` + `view commerce_product_review`; the anonymous route only performs a login redirect. No `_access: TRUE` on mutating endpoints, no raw SQL, no weak tokens.
