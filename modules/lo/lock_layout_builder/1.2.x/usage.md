<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Lock Layout Builder integrates core [Layout Builder](https://www.drupal.org/docs/8/core/modules/layout-builder)
with the [Content Lock](https://www.drupal.org/project/content_lock) module so that Layout Builder
section- and block-editing operations are blocked unless the current user holds the content lock on the
entity being laid out. This prevents two editors from concurrently mutating the same entity's layout and
clobbering each other's work.

---

The module registers a custom access check service (`lock_layout_builder.access_check`, applies to the
`_lock_layout_builder_access` route requirement) and a route subscriber
(`LockLayoutBuilderRouteSubscriber`) that adds that requirement to the Layout Builder mutation routes:
`choose_section`, `configure_section(_form)`, `add_section`, `remove_section`, `choose_block`,
`add_block`, `choose_inline_block`, `move_block(_form)`, `update_block`, and `remove_block`. The access
check (`LockLayoutBuilderAccessCheck::access`) resolves the entity from the route's `section_storage`
entity context, then returns `AccessResult::allowed()` only if
`ContentLock::isLockedBy($entity_id, $langcode, 'layout_builder', $account->id(), $entity_type)` is true
for the current user; otherwise `AccessResult::forbidden()`. When no entity context is present it falls
back to `allowed()` (deferring to Layout Builder's own permissions), and the result carries the
`section_storage` as a cacheable dependency. Enforcement is fail-safe: the lock must be held by *you* to
operate. Depends on `layout_builder` and `content_lock`.

---

- Prevent two editors from simultaneously editing the same node's Layout Builder layout.
- Block add/edit/move/remove of sections unless the current user owns the content lock.
- Block add/edit/move/remove of Layout Builder blocks under the same lock rule.
- Warn/stop a second editor who opens a layout already locked by a colleague.
- Combine Content Lock's entity-edit locking with Layout Builder operations for consistent locking.
- Protect override layouts on individual nodes from concurrent changes.
- Protect default layouts on a display from concurrent changes.
- Ensure inline block creation is gated by the same lock.
- Ensure block moves (including cross-region `move_block`) respect the lock.
- Avoid lost updates when several people manage a landing page's layout.
- Keep Layout Builder AJAX operations consistent with a per-entity editorial lock.
- Enforce a "one editor at a time" workflow on high-traffic landing pages.
- Let the lock holder work uninterrupted while others get forbidden responses.
- Fall back to core Layout Builder permissions when no entity is in context.
- Add lock semantics to Layout Builder without writing custom access code.
- Give editorial teams a safety net against overwrite conflicts in Layout Builder.
