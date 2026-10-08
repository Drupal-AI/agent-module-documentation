<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Meta Entity stores metadata *about* an entity in a separate `meta_entity` content entity linked to the host by a dynamic entity reference, so data like counters, ratings, sync state or editorial notes can be attached to any entity — including entity types you don't control — without adding a field to the host or re-saving it.

---

Adding a field to the host is the obvious way to attach data, and it is the wrong tool in several recurring cases: the data changes far more often than the host and would create a revision every time; it is operational rather than editorial and should not appear on the edit form; it belongs to an entity type another module owns; or a background process writes it and must not touch the host's `changed` timestamp. Meta Entity provides the sidecar. You define meta entity *types* as bundle config entities (`meta_entity_type`) whose `mapping` declares which host entity-type/bundles they may annotate; each type can expose a computed reverse-reference field on the host (`field_name`) and optionally auto-create a meta entity when a host is inserted (`auto_create`). A meta entity carries a required `target` field (dynamic_entity_reference, cardinality 1) so one type can serve nodes, users, media and more without a field per target type, and a host may hold at most one meta entity of a given type (enforced by validation constraints). You create/read them in PHP via `MetaEntity::create()`, `MetaEntity::loadOrCreate()`, the host's computed reverse field, or the per-type `meta_entity.repository` service; on meta-entity save the host's cache tags are invalidated and on host delete the metadata is cascade-deleted. Access is governed by `administer meta entity` plus per-type `create|view|update|delete <type> meta-entity` permissions generated at runtime. The trade-off: because the data is not on the host it is not in the host's revisions, not in its default rendering, and not automatically in its search index — everything that reads it (Views included) must know to look. Requires Dynamic Entity Reference (`^2 || ^3 || ^4`); core `^10 || ^11`.

---

- Store per-entity view or download counters without a field on the host.
- Keep frequently changing metadata out of the host's revisions.
- Attach data to entity types provided by other modules.
- Record background-process or sync state separately from content.
- Avoid touching a host's `changed` timestamp when metadata updates.
- Attach one metadata type to several entity types at once.
- Store ratings or likes as their own entity.
- Keep internal editorial notes off the entity edit form.
- Auto-create a metadata record whenever a node is created.
- Expose a computed reverse-reference field back to the metadata on the host.
- Read a counter with `$node->visits->entity->field_count->value`.
- Increment a value without re-saving the host entity.
- Cascade-delete metadata automatically when the host is deleted.
- Model metadata with its own translatable content-entity bundle.
- Grant per-type permissions to control who edits which metadata.
- Query all metadata for a host through the repository service.
- Load-or-create a meta entity in one call for upsert-style updates.
- Store data that has a different lifecycle from the content itself.
- Keep the host's edit form uncluttered by non-editorial data.
- Track a host's utilization on third-party systems.
