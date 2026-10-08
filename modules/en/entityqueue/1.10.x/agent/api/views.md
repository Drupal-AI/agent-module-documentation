# Views integration

Entityqueue ships Views plugins (see `entityqueue.views.inc` and `src/Plugin/views/*`) so you
can display and order content by queue membership:

| Kind | Plugin | Use |
|---|---|---|
| relationship | `EntityQueueRelationship` | Join a base entity View to its subqueue items. |
| sort | `EntityQueuePosition` | Order results by their position within the subqueue. |
| sort/filter | `EntityQueueInQueue` | Sort or filter by whether an entity is in a queue. |
| filter | `EntityQueueInQueue` (filter) | Restrict results to (or exclude) queued entities. |
| field | `EntityQueuePosition` | Output an item's numeric position. |
| join | `CastedFieldJoin` | Internal join helper for the above. |

Typical block: add the entity type as the base, add the **Entityqueue relationship** for the
target queue, add the **queue position** sort (ascending) to render items in manual order, and
filter to the desired queue/subqueue. `entityqueue_views_pre_render()` and
`entityqueue_views_query_alter()` finalize ordering at render time.
