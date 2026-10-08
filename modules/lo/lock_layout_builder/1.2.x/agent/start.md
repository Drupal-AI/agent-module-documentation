<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lock_layout_builder — agent start

Bridges core **Layout Builder** and the **Content Lock** module: Layout Builder section/block mutation
routes are gated so only the user who currently holds the content lock on the entity may operate.

Mechanics:
- `LockLayoutBuilderRouteSubscriber` adds requirement `_lock_layout_builder_access` to the LB routes
  (choose/add/configure/remove/move for sections and blocks).
- `LockLayoutBuilderAccessCheck::access` reads the entity from `section_storage`'s entity context and
  returns `AccessResult::allowed()` only when
  `ContentLock::isLockedBy(entity_id, langcode, 'layout_builder', uid, entity_type)`; else `forbidden()`.
- No entity context → `allowed()` (defers to LB's own perms). Result adds `section_storage` as a
  cacheable dependency.

Depends on `layout_builder` + `content_lock`. Access logic is sound and fail-closed (lock must be held
by the current user). No routes of its own, no permissions defined.
