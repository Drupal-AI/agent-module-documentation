# Configure queues

![Entityqueues list](../../../../../../../screenshots/entityqueue/1.10.x/queues.png)

Queues are `entity_queue` config entities managed at `/admin/structure/entityqueue`
(add form route `entity.entity_queue.add_form`). Config schema in
`config/schema/entityqueue.schema.yml`. Each queue references a target entity type and is
driven by a **handler plugin**.

Per-queue settings:
- **Handler** — `simple` (one fixed subqueue) or `multiple` (editors create many named
  subqueues). With `entityqueue_smartqueue` enabled, also `smartqueue` (auto subqueue per
  entity of a chosen type).
- **Settings (target)** — which entity type / bundles items may reference, and the selection
  handler.
- **Minimum / maximum size** — enforced by the `QueueSize` validation constraint
  (`Plugin/Validation/Constraint`). Set max to 0 for unlimited.
- **Reverse in subqueue view**, act-as-queue behavior, etc. (handler-dependent).

Editing items: each subqueue is an `entity_subqueue` content entity; the
`entityqueue_dragtable` field widget renders the ordered items as a drag-and-drop table.
Enable/disable a queue via `entity.entity_queue.enable` / `.disable` routes. Queues are
exportable configuration; subqueue *contents* are content entities (not config).

To display queued items, use the Views integration → [../api/views.md](../api/views.md).
