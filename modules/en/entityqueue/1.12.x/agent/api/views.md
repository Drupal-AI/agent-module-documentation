# Views integration

Entityqueue ships Views plugins (`src/Plugin/views/*`; Views data and render hooks now live in
OOP hook classes `src/Hook/EntityqueueViewsHooks.php`) so you can display and order content by
queue membership:

| Kind | Plugin | Use |
|---|---|---|
| relationship | `EntityQueueRelationship` | Join a base entity View to its subqueue items. `limit_queue` is a **list** — it can restrict to several queues at once. |
| sort | `EntityQueuePosition` | Order results by their position within the subqueue. |
| sort/filter | `EntityQueueInQueue` | Sort or filter by whether an entity is in a queue. |
| filter | `EntityQueueInQueue` (filter) | Restrict results to (or exclude) queued entities. |
| field | `EntityQueuePosition` | Output an item's numeric position. |
| join | `CastedFieldJoin` | Internal join helper for the above. |

Typical block: add the entity type as the base, add the **Entityqueue relationship** for the
target queue(s), add the **queue position** sort (ascending) to render items in manual order, and
filter to the desired queue/subqueue. `entityqueue_views_pre_render()` and
`entityqueue_views_query_alter()` (both defined as hook methods) finalize ordering at render time.

Note: a post-update (`entityqueue_post_update_relationship_limit_queue_list`) normalizes older
scalar/keyed `limit_queue` values in existing views to the current sequence format.
