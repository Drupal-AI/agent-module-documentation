# Drupal 8+ to Drupal 8+ migration (migrate_drupal_d8) — agent index

Provides ONE migrate **source plugin**, `d8_entity`, that reads content entities (and their Field
API values) directly from another Drupal 8/9/10/11 site's database. No config, no permissions, no
routes, no Drush, no services. Depends on core `migrate`. You reference the plugin from migration
YAML (usually via `migrate_plus`/`migrate_tools`).

- **The `d8_entity` source plugin: config keys, YAML shape, sub-fields, deprecated aliases** →
  [plugins/d8-entity-source.md](plugins/d8-entity-source.md)

Key facts:
- Source id: `d8_entity`. Required keys: `key` (source DB connection), `entity_type`. Optional: `bundle`.
- Sub-field columns use a delta index: `'body/value': 'body/0/value'`.
- Deprecated pre-typed aliases (avoid): `d8_node`, `d8_user`, `d8_file`, `d8_taxonomy_term` — each just
  sets `entity_type` and extends `d8_entity`.
- The source database is declared in `settings.php` `$databases[<key>][<target>]` and referenced by `key`.
- Class: `Drupal\migrate_drupal_d8\Plugin\migrate\source\d8\ContentEntity` (extends `SqlBase`).
