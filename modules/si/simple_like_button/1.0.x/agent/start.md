<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Like Button (simple_like_button) — agent index

**A placed block rendering an AJAX like/unlike button for the entity on the current page, for authenticated users.**

- **Version:** 1.0.x
- **Core:** ^10 || ^11
- **Block:** `simple_like_button` (`SimpleLikeButtonBlock`) → renders `LikeForm`
- **Entity:** `simple_like` content entity, base table `simple_like` (fields `entity`, `entity_id`, `bundle`, `user_id`, `status`), admin permission `administer like entities`
- **Storage/UI:** placed via the core Block UI; theme hook `block_like_button`; library `simple_like_button/like`
- **Security:** like/unlike requires an authenticated user (anonymous gets no button); `LikeForm` is a standard `FormBase`, so submissions carry Drupal's CSRF form-token protection; one like row per user per entity (toggle keyed on the current uid). The `entity`/`entity_id`/`bundle` arrive as form values and are not validated against a real entity — an authenticated user could record a like against arbitrary identifiers, but the impact is bounded to a per-user like row/count (no arbitrary write). No anonymous mutating endpoint.

See [configure/placement.md](configure/placement.md) for placement and permissions.