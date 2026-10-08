<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Live Blog - agent index

**Live-blogging** entity + AJAX polling feed (version **1.0.6**, core `^8.8||^9||^10`; depends on `node`, `user`).

- `live_blog` revisionable entity, per-operation permissions, log table drives deltas.
- NOTE: route `live_blog.api` (`/api/live-blog/api/{parent_id}/{lid}`) uses `_access: 'TRUE'` (anonymous) and `APIController::get()` renders live_blog entities without a publish/entity-access check - low-severity unauthenticated content disclosure (see security notes).
- Settings route `live_blog.admin.structure.settings`.
- Category: Content display / Views auto-refresh.
