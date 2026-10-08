# The three queue plugins

All three implement Purge's `@PurgeQueue` plugin type (namespace
`Plugin/Purge/Queue`). `purge_queues` does **not** define a plugin type — to add your own queue
you implement Purge's type, not this module's. Below is what each provided plugin does.

## `database_alt` — "Database (extended)"

`AltDatabaseQueue extends DatabaseQueue` (Purge core). Same behavior as the core `database`
queue, but its own table **`purge_queue_alt`** adds `type` and `expression` columns (the
invalidation type and expression, from `ProxyItemInterface::DATA_INDEX_TYPE` /
`DATA_INDEX_EXPRESSION`) alongside the serialized `data` blob. Indexes: `type_expression`,
`created`, `expire`. The serialized item data is unchanged; the extra columns make items
queryable and enable deduplication in the subclasses.

## `database_unique` — "Database unique"

`DatabaseUniqueQueue extends AltDatabaseQueue`. Overrides `createItem()` /
`createItemMultiple()` to call `findItem()` first: a `SELECT item_id ... WHERE type = ? AND
(expression = ? OR expression IS NULL) LIMIT 1`. If a matching row exists, its id is returned and
**no new row is inserted** — so an invalidation with the same type+expression is never queued
twice. This directly solves the "duplicated queued items" problem
(drupal.org/node/2851893). Uses the same `purge_queue_alt` table.

## `database_unique_upsert` — "Database unique (upsert)"

`DatabaseUniqueUpsertQueue extends DatabaseQueue`. Table **`purge_queue_upsert`** whose
**primary key is a varchar hash**: `getHash()` = `sha256(type . ':' . expression)` (falls back to
`sha256(serialize(data))`). `createItem()`/`createItemMultiple()` use an SQL `UPSERT` keyed on
`item_id`, so re-queuing the same invalidation just overwrites the existing row — deduplication
with a single write and no pre-SELECT, for better performance. Because the primary key is a string
(not an auto-increment int), it re-implements `claimItem`, `claimItemMultiple`,
`releaseItemMultiple`, and `selectPage` from the parent to avoid casting `item_id` to int.

## Choosing between them

- `database_unique_upsert` — best performance for dedup; recommended for high-churn sites.
- `database_unique` — dedup via pre-check; simpler, shares the extended table.
- `database_alt` — no dedup, just the extra queryable columns (rarely selected on its own).

## Schema/install note

`purge_queues.install`'s `purge_queues_update_8001()` widens the `expression` column of
`purge_queue_alt` to allow NULL (2048-char varchar). Tables are created lazily by Purge's queue
schema handling when a queue is first used.
