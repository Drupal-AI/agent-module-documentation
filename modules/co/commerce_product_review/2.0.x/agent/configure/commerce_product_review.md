<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Commerce Product Review

**Depends on:** `commerce_price`, `commerce_product`. **Requires** the rateit.js library at
`libraries/jquery.rateit/scripts` for the star widgets/formatters.

## Review types (bundles)

Managed at **`/admin/commerce/config/product-review-types`** (config entity
`commerce_product_review_type`, permission `administer commerce_product_review_type`). Each type:
- is scoped to one or more **commerce_product types** (only those products expose the review form);
- carries a **notification email** address (a mail is sent to it on each new review);
- supports Field UI for extra fields, form modes, and display modes.

## Routes

| Route / path | Access |
|---|---|
| `/product/{commerce_product}/add-review` | `_custom_access` — published product + matching review type + no existing review by this user + `createAccess` |
| `/product/{commerce_product}/edit-review` | `_custom_access` — owner update access |
| `/product/{commerce_product}/delete-review` | `_custom_access` — owner delete access |
| `/product/{commerce_product}/login-to-review` | `_role: anonymous` (login redirect only) |
| `/product/{commerce_product}/reviews` | `_entity_access: commerce_product.view` + `_permission: view commerce_product_review` |
| `/user/{user}/reviews` | `_custom_access` → `$user->access('view')` |
| `/admin/commerce/product-reviews` | entity admin list (bulk publish/unpublish/delete) |

One review per user per product is enforced in the access callback via
`ProductReviewStorage::loadByProductAndUser()`.

## Permissions

- `administer commerce_product_review_type` — manage review-type bundles (restricted).
- `publish commerce_product_review` — reviewers with this role get their reviews **auto-published**;
  otherwise reviews are created **unpublished** (admin approval).
- Plus the entity-API per-bundle set from `EntityPermissionProvider`:
  `administer commerce_product_review`, and view/create/update/delete own+any per bundle.

## Overall rating

The `OverallRatingItem` field (widgets `OverallRatingDefaultWidget` / `StarsRatingWidget`;
formatters `OverallRatingDefaultFormatter` / `OverallRatingStarsFormatter` /
`SingleRatingStarsFormatter`) is attached to products. On review insert/update/delete,
`ProductReviewEventSubscriber` calls `ProductReviewManager::updateOverallRating()`, which averages
all published reviews' ratings using the `commerce_price` `Calculator` (3-decimal precision) and
writes the average + count back onto the product. Enable the "Overall rating" field in the product
display to show it.

## Services

- `commerce_product_review.product_review_manager` (`ProductReviewManager`) — rating aggregation.
- `commerce_product_review.product_review_email` (`ProductReviewEmail`) — notification mail.
- `commerce_product_review.product_review_subscriber` — recompute rating + send email on CUD.
