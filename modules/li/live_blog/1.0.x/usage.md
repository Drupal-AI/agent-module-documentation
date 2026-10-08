<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Live Blog provides a real-time posting feature whose feed updates in the browser via AJAX polling.

---

The module defines a `live_blog` content entity (with revisions and per-operation permissions) attached to a parent node; as editors create, update, or delete posts, a log table records the change, and a front-end script polls the endpoint `/api/live-blog/api/{parent_id}/{lid}` to append, replace, or remove rendered posts since the last seen log id. Entity management is permission-gated, but the polling API route itself is open (`_access: TRUE`). It suits event/match live coverage.

---

- Run a live blog of an event or match.
- Post updates that appear without a page reload.
- Attach live posts to a parent node.
- Stream new posts to readers via AJAX polling.
- Update or delete a live post in-place for readers.
- Order new posts ascending or descending.
- Track post changes in a log table.
- Manage live posts as a revisionable entity.
- Gate post create/edit/delete by permission.
- Provide view/revision permissions per operation.
- Render posts with a dedicated theme template.
- Poll a lightweight endpoint for deltas.
- Support Drupal 8.8, 9, and 10.
- Cover breaking-news style content.
- Configure behaviour from an admin settings form.
- Deliver near-real-time updates to anonymous readers.
