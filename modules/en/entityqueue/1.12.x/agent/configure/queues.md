# Configure queues

Queues are `entity_queue` config entities managed at `/admin/structure/entityqueue`
(add form route `entity.entity_queue.add_form`). Config schema in
`config/schema/entityqueue.schema.yml`. Each queue references a target entity type and is
driven by a **handler plugin**.

Per-queue settings (`entity_settings` + `queue_settings`):
- **Handler** — `simple` (one fixed subqueue) or `multiple` (editors create many named
  subqueues). With `entityqueue_smartqueue` enabled, also `smartqueue` (auto subqueue per
  entity of a chosen type).
- **Entity settings (target)** — `target_type` (which entity type items reference), the
  reference method `handler`, and its `handler_settings` (bundles / selection).
- **Minimum / maximum size** (`min_size` / `max_size`) — enforced by the `QueueSize`
  validation constraint (`Plugin/Validation/Constraint`). Set max to 0 for unlimited.
- **`act_as_queue`** — when the queue is full, adding an item drops one from the far end.
- **`reverse`** — add new items to the top instead of the bottom. (The old
  `reverse_in_admin` setting was removed; a post-update migrates it to `reverse`.)

Editing items: each subqueue is an `entity_subqueue` content entity (revisionable and
translatable); the `entityqueue_dragtable` field widget renders the ordered items as a
drag-and-drop table. Widget settings include `link_to_entity`, `link_to_edit_form`, and
`show_publish_status` (`unpublished` | `all` | `off`) which marks item publication status.

Enable/disable a queue via `entity.entity_queue.enable` / `.disable` routes. Queues are
exportable configuration; subqueue *contents* are content entities (not config).

To display queued items, use the Views integration → [../api/views.md](../api/views.md).
