<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `drush.services.yml` (`SearchApiAlgoliaCommands`).

## `search_api_algolia:delete` (alias `sapia-d`)

Fetches queued deletions and deletes those objects from Algolia. Deletions are queued in the
`search_api_algolia_deleted_items` DB table (index_id + object_id) — for example by
`hook_entity_delete` / batched index deletion — and this command flushes them in batches.

| Option | Default | Meaning |
|---|---|---|
| `--batch-size` | `100` | Number of items to process per batch run. |

```bash
# Delete all queued Algolia objects (batch size 100):
drush sapia-d
drush search_api_algolia:delete

# With a custom batch size:
drush sapia-d --batch-size=100
```

The command builds a Drupal batch (`batchStart` / `batchProcess` / `batchFinish`) that groups
queued object ids by their index/server and removes them from the corresponding Algolia
indexes. Requires a working Algolia connection (valid Application ID + Write API Key on the
server) to actually delete remote objects.
