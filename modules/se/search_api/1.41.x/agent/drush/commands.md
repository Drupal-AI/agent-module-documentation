# Drush commands

Provided by `src/Drush/Commands/SearchApiDrushCommands.php` (namespace `search-api:`,
most have short aliases). Run against index / server machine ids.

| Command | Does |
|---|---|
| `search-api:list` | List all indexes with status, tracked/indexed counts. |
| `search-api:status [INDEX]` | Indexing status (total / indexed / remaining). |
| `search-api:index [INDEX] [--limit] [--batch-size]` | Index tracked items (all indexes if none given). |
| `search-api:clear [INDEX]` | Delete all indexed data for the index. |
| `search-api:reset-tracker [INDEX] [--entity-types]` | Mark all items for re-indexing (rebuild queue). |
| `search-api:rebuild-tracker [INDEX]` | Rebuild the tracking table from scratch. |
| `search-api:enable` / `search-api:disable` INDEX | Enable/disable an index. |
| `search-api:enable-all` / `search-api:disable-all` | Toggle every index. |
| `search-api:search INDEX "keys"` | Run a keyword search and print results. |
| `search-api:set-index-server INDEX SERVER` | Assign an index to a server. |
| `search-api:server-list` | List servers. |
| `search-api:server-enable` / `server-disable` SERVER | Toggle a server. |
| `search-api:server-clear SERVER` | Clear all indexes on a server. |

Typical reindex cycle:
```
drush search-api:reset-tracker my_index
drush search-api:index my_index
drush search-api:status my_index
```
