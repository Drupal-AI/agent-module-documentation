# Configure which entity types are indexed

Settings form: route `taxonomy_entity_index.admin` → `/admin/config/system/taxonomy-entity-index`
(permission `administer site configuration`). Config object `taxonomy_entity_index.settings`.

| Key | Type | Meaning |
|---|---|---|
| `types` | sequence of strings | Entity type IDs to index (e.g. `node`, `media`, `taxonomy_term`). Only content entity types with a base table and an **integer** ID key appear as options. |
| `index_revisions` | bool | Keep an index row per historical revision instead of only the current one. Impacts performance. |
| `index_per_field` | bool | Write a separate row per field even when the same term is referenced by multiple fields (otherwise duplicates across fields are collapsed). |

The form lists every eligible content entity type; `types` is **required** (pick at least one).
Changing `types` does not retroactively index existing content — run a rebuild afterwards.

## Read / write the config

```bash
drush cget taxonomy_entity_index.settings
drush cset taxonomy_entity_index.settings types.0 node -y        # index nodes
drush cset taxonomy_entity_index.settings index_revisions 1 -y
```

Or in PHP (sets the whole list at once):

```php
\Drupal::configFactory()->getEditable('taxonomy_entity_index.settings')
  ->set('types', ['node', 'media'])
  ->set('index_revisions', FALSE)
  ->set('index_per_field', FALSE)
  ->save();
```

## Reindex after changing settings

- UI: reindex form at `taxonomy_entity_index.admin_reindex`
  (`/admin/config/system/taxonomy-entity-index/reindex`) — runs a batch that clears and rebuilds
  the table for the configured types.
- CLI: `drush taxonomy_entity_index:rebuild` — see [../drush/rebuild.md](../drush/rebuild.md).

## What gets indexed

For each configured entity type, on insert/update the module scans the entity's
**entity_reference fields whose target is `taxonomy_term`** and writes a row per referenced term.
Entity/revision/term/field-instance deletes remove the matching rows automatically.
