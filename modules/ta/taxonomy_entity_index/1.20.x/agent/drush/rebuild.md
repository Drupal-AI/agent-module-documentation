# Drush: rebuild the index

```
drush taxonomy_entity_index:rebuild [entity_types]
```

Aliases: `tei:rebuild`, `taxonomy-entity-index-rebuild`, `tei-rebuild`.

- No argument → rebuilds every entity type listed in `taxonomy_entity_index.settings:types`.
- Argument → a comma-separated list of entity types to rebuild instead, e.g.:

```bash
drush taxonomy_entity_index:rebuild            # all configured types
drush tei:rebuild node,media                   # only nodes and media
```

It builds a batch (`BatchService::processEntityTypeReindex`) that loads every entity of the given
type(s) and re-runs the indexing logic, then processes it with `drush_backend_batch_process()`.
The batch clears existing rows for a type before reinserting, so it is safe to run repeatedly.

Command class: `Drupal\taxonomy_entity_index\Commands\TaxonomyEntityIndexCommands` (registered in
`drush.services.yml`). Run a rebuild after changing which `types` are indexed, or after a bulk
import that bypassed entity save hooks.
