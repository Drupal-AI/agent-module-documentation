<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Algolia Search (search_api_algolia) — agent index

A **Search API backend** that indexes Drupal content into hosted Algolia (indexing only; the
search UI is front-end JS). Needs the `algolia/algoliasearch-client-php` (^4.0) library and an
Algolia account. **No configure route of its own** — you configure a Search API server + index.

- **Add the Algolia server, backend config keys, per-index options, module settings** →
  [configure/backend-and-index.md](configure/backend-and-index.md)
- **Backend + processor plugins (`search_api_algolia`, `algolia_item_splitter`)** →
  [plugins/backend-processor.md](plugins/backend-processor.md)
- **Drush: `search_api_algolia:delete` (alias `sapia-d`)** →
  [drush/commands.md](drush/commands.md)
- **Alter hooks (client config, objects, sorts)** →
  [hooks/hooks.md](hooks/hooks.md)

Key facts:
- Backend plugin id **`search_api_algolia`** (label "Algolia"). Server `backend_config`:
  `application_id`, `api_key` (Write API Key), `disable_truncate`.
- Module settings object **`search_api_algolia.settings`**: `debug` (bool, default false),
  `wait_for_delete` (bool, default false).
- Per-index options (set on the Search API index): `algolia_index_name`,
  `algolia_index_apply_suffix`, `algolia_index_batch_deletion`, `object_id_field`,
  `partially_update_objects`.
- Processor **`algolia_item_splitter`** splits big items into multiple Algolia records.
- Two service helpers: `search_api_algolia.helper`, `search_api_algolia.search_query_helper`.
