# Taxonomy Entity Index — agent index

Maintains a denormalized `taxonomy_entity_index` table mapping content entities → referenced
taxonomy terms, for the entity types you select (a cross-entity replacement for core's node-only
`taxonomy_index`). Kept current via entity CRUD hooks; rebuildable by batch/Drush. Adds Views
argument/field/filter plugins with hierarchy depth. Depends on core `taxonomy`. No permissions of
its own (admin routes need `administer site configuration`).

- **Pick which entity types to index, the settings keys, and reindex** →
  [configure/settings.md](configure/settings.md)
- **The `taxonomy_entity_index:rebuild` Drush command** →
  [drush/rebuild.md](drush/rebuild.md)
- **The index table schema, how rows are written, and the Views plugins** →
  [api/index-table.md](api/index-table.md)

Key facts:
- Config `taxonomy_entity_index.settings`: `types` (sequence of entity_type ids to index),
  `index_revisions` (bool), `index_per_field` (bool).
- Settings form route `taxonomy_entity_index.admin` (`/admin/config/system/taxonomy-entity-index`);
  reindex form `taxonomy_entity_index.admin_reindex`.
- Drush: `taxonomy_entity_index:rebuild` (aliases `tei:rebuild`, `tei-rebuild`).
- Only entity types whose ID is an integer are indexed.
