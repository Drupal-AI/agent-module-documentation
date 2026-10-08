# entityqueue_smartqueue — agent start

Entityqueue submodule. Adds the **`smartqueue`** EntityQueueHandler: one subqueue is auto
created/maintained for each entity of a chosen entity type (and optional bundles). Requires
`entityqueue`. No config route of its own — configured on a queue's handler settings at
`/admin/structure/entityqueue`.

- Configure a smart queue (target entity type / bundles, sync behavior) → [configure/smartqueue.md](configure/smartqueue.md)
