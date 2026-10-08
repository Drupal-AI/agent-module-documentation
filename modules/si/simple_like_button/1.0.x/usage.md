<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Like Button places a block that lets logged-in users like or unlike the entity shown on the current page, updating the count via AJAX.

---

The block (`simple_like_button`) renders a Drupal form (`LikeForm`) that detects the entity in the current route, shows a "Like ·"/"Liked ·" button with the current count, and (when there are likes) a "Liked by:" list of usernames. Clicking submits over AJAX: if the current user has no like row for that entity it creates a `simple_like` content entity (owned by the current user); if a row exists it deletes it. The button label, colour, and the "you liked" marker update client-side without a page reload. Anonymous users and non-entity pages get no button.

Likes are stored as `simple_like` content entities in the `simple_like` table (fields: `entity`, `entity_id`, `bundle`, `user_id`, `status`). Like/unlike is limited to authenticated users, and because `LikeForm` is a standard Drupal `FormBase` it carries Drupal's CSRF form-token protection; a user can hold at most one like per entity (the toggle keys on the current user's row). The block is placed and administered through the core Block UI. Note that the entity/entity_id/bundle travel as form values, so an authenticated submitter could in principle record a like against arbitrary identifiers — the effect is limited to a per-user like row and count.

---
- Add a like/unlike button to nodes via a placed block
- Let authenticated users like the entity on the current page
- Show a live like count that updates over AJAX without a page reload
- Toggle a like off by clicking again (delete the user's row)
- Display a "Liked by:" list of the users who liked the current entity
- Highlight the current user's own like with a "You," marker
- Place the like button in any block region through the Block UI
- Restrict likes to a specific page/entity via block visibility settings
- Track likes as queryable `simple_like` content entities
- Count likes per entity and bundle from the `simple_like` table
- Hide the button from anonymous users automatically
- Skip rendering on pages that have no entity in the route
- Style the button/count with the shipped `simple_like_button/like` library
- Build a simple social-proof signal on articles or products
- Report per-entity like totals for basic engagement analytics
- Let each user like a given entity at most once
- Rely on Drupal form CSRF tokens for the like/unlike submission