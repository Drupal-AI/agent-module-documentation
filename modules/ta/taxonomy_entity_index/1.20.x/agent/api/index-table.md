# Index table & Views plugins

## `taxonomy_entity_index` table

Defined in `hook_schema()`. One row per (entity revision, field, delta, term):

| Column | Type | Notes |
|---|---|---|
| `entity_type` | varchar(32) | Part of primary key |
| `bundle` | varchar(128) | |
| `entity_id` | int unsigned | Part of primary key |
| `revision_id` | int unsigned | Part of primary key; = `entity_id` when not revisionable, or when `index_revisions` off it tracks the current revision |
| `field_name` | varchar(32) | Part of primary key; the taxonomy reference field |
| `delta` | int unsigned | Part of primary key; the field item delta |
| `tid` | int unsigned | The referenced term ID (indexed) |

Primary key: `(entity_type, entity_id, revision_id, field_name, delta)`. Indexes on `field_name+entity_type+bundle`, `tid`, `revision_id`.

Query it directly, e.g. "how many nodes reference term 5":

```php
$count = \Drupal::database()->select('taxonomy_entity_index', 'tei')
  ->condition('entity_type', 'node')->condition('tid', 5)
  ->countQuery()->execute()->fetchField();
```

## How rows are written (hooks)

- `hook_entity_insert` / `hook_entity_update` → `taxonomy_entity_index_entity_update()`: only for
  configured `types` and integer-ID entities; clears prior rows (per-revision if `index_revisions`,
  else all for the entity) and inserts a row per referenced term. `index_per_field` controls whether
  the same term in multiple fields yields multiple rows.
- `hook_entity_delete` / `hook_entity_revision_delete` / `hook_taxonomy_term_delete` /
  `hook_field_config_delete` remove the relevant rows.

Helper: `taxonomy_entity_index_get_taxonomy_field_names($entity_type_id)` returns the
taxonomy_term entity-reference field names per bundle (statically + cache-backed).

## Views plugins

| Kind | Plugin id | Purpose |
|---|---|---|
| Argument | `taxonomy_entity_index_tid_depth` | Contextual filter by term ID with hierarchy `depth`, `break_phrase`, `use_taxonomy_term_path` |
| Argument | `taxonomy_entity_index_term_uuid_depth` | Same, keyed by term UUID |
| Field | `taxonomy_entity_index_tid` | Render an entity's terms (optional link to term, limit by vocabulary) |
| Filter | `taxonomy_entity_index_tid_depth` | Filter by term ID with `depth` (extends core `taxonomy_index_tid`) |

These join the `taxonomy_entity_index` table, so a View of any indexed entity type can be argued
or filtered by term with depth — the cross-entity equivalent of core's node taxonomy Views support.
