<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A glue submodule that makes DraggableViews manual-ordering weights travel with content during Content Sync push/pull, so drag-and-drop ordering is preserved across syndicated sites.

---

DraggableViews stores each entity's manual sort weight in its own `draggableviews_structure` database table rather than in a field, so Content Sync would not normally carry that ordering when it syndicates an entity. This submodule bridges that gap with a single event subscriber, `DraggableViewsSyncExtend`, that listens to three Content Sync events: `BeforeEntityTypeExport` (to declare an extra `draggableviews` property on supported entity types), `BeforeEntityPush` (to read the weight rows from the `draggableviews_structure` table and attach them to the outgoing payload) and `AfterEntityPull` (to write the received weights back into the local `draggableviews_structure` table). It requires both `cms_content_sync` and the contrib `draggableviews` module, has no configuration, permissions, Drush commands or plugins of its own, and does nothing unless those events fire during a real sync. The extra payload property is named `draggableviews` (`DraggableViewsSyncExtend::PROPERTY_NAME`).

---

- Keep a manually drag-ordered view's ordering identical between a staging site and production.
- Syndicate a curated "featured" list whose order editors set by dragging, without re-sorting on the target.
- Preserve DraggableViews weights when pushing nodes from a content hub to subscriber sites.
- Pull ordered content into a brand site and have it appear in the same editor-defined order.
- Avoid re-doing manual ordering on every site after content is syndicated.
- Carry the `draggableviews_structure` weight rows alongside the entity during push.
- Restore drag-ordering into the local structure table automatically on pull.
- Support editorial workflows where ordering is meaningful (top stories, homepage promos).
- Extend the Content Sync payload for an entity type with a `draggableviews` property.
- Enable ordered-list syndication with zero configuration once both modules are present.
- Keep a promotions carousel's manual order consistent across a multi-site fleet.
- Ensure a "staff picks" ordering set on one site propagates to others.
- Reduce editor workload by syncing ordering instead of re-ordering per environment.
- Guarantee that a reordered menu-like view stays reordered after a pull.
- Serve as a reference for how to extend Content Sync via its push/pull events.
- Add ordering fidelity to any Content Sync Flow that includes DraggableViews-ordered content.
- Prevent ordering drift between sites that share the same content pool.
