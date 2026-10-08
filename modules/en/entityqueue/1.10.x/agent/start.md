# entityqueue — agent start

Collect entities into arbitrarily ordered, drag-and-drop lists (queues → subqueues). Nodequeue
successor. Config UI: **Admin → Structure → Entityqueues**
(`/admin/structure/entityqueue`, route `entity.entity_queue.collection`). Submodule:
`entityqueue_smartqueue`.

- Create/configure queues (Simple vs Multiple handler, size limits) → [configure/queues.md](configure/queues.md)
- Define a custom queue behavior (handler plugin) → [plugins/handler.md](plugins/handler.md)
- Manipulate subqueue items in code (add/remove/clear/reverse/shuffle) → [api/subqueues.md](api/subqueues.md)
- Show queued items in Views (relationship/sort/filter/field) → [api/views.md](api/views.md)
- Add/remove items via Actions, Rules, ECA → [extend/actions.md](extend/actions.md)
- Permissions (global + dynamic per-queue) → [permissions/permissions.md](permissions/permissions.md)
