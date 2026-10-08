# Configuration

Commerce Product Review is configured in three places: the **review types** page,
the standard **permissions** page, and your product's **display** settings. You need
the "administer commerce product review type" permission (an administrator by
default) to manage review types.

## Review types (bundles)

Go to **Commerce → Configuration → Product review types**
(`/admin/commerce/config/product-review-types`). A **default** review type is
provided; edit it or create your own. On a review type's edit page:

- **Enabled product types** — select which Commerce product types this review type
  applies to. This is required: the review form only appears on products whose type
  is selected here, so if you enable no product types, nobody can review anything.
- **Notification email** — an address that receives an email each time a new review
  is submitted for this type. Leave it blank if you do not want notifications.
- **Fields, form display, and view display** — because a review type is a bundle,
  you can add extra fields (customer photos, pros/cons, video, and so on) via Field
  UI and arrange the review form and its display like any other entity.

Create multiple review types when different product types need different review
forms or different notification recipients.

## The "Overall rating" field on products

The average rating is stored on the product through an **Overall rating** field. To
show it on product pages, go to your product type's **Manage display**
(for example `/admin/commerce/config/product-types/default/edit/display`) and make
sure the **Overall rating** field is enabled and placed where you want it. Choose a
formatter to show it as a number or as rateit.js stars (stars require the rateit.js
library — see [Installation](../installation/index.md)). The average and review
count are recomputed automatically whenever a review is added, edited, or deleted.

## Permissions

On **People → Permissions** (`/admin/people/permissions`) you will find:

- **Administer commerce product review type** — manage review-type bundles; keep this
  restricted to administrators.
- **Publish commerce product review** — reviewers whose role holds this permission
  get their reviews **published immediately**. Without it, a new review stays
  **unpublished** until an administrator approves it. Use this to decide whether you
  moderate reviews before they appear or trust certain roles to post directly.
- Per-bundle **view / create / update / delete (own and any)** permissions generated
  by Drupal's Entity API, plus a general "administer commerce product review"
  permission — grant these to let customers write, view, edit, and delete their own
  reviews.

A typical storefront setup: give authenticated users the "create" and
"update/delete own" permissions for your review bundle, leave "publish" off so an
administrator approves reviews, and keep the two "administer" permissions to staff.

## Managing reviews

Administrators manage all reviews from **Commerce → Product reviews**
(`/admin/commerce/product-reviews`) — a view with sorting, filtering, and bulk
actions to publish, unpublish, or delete many reviews at once.
