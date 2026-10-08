<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Defined in `\Drupal\elasticsearch_helper\Commands\ElasticsearchHelperCommands` (registered via
`drush.services.yml`, requires Drush ^10 || ^11). All operate on `ElasticsearchIndex` plugins.
Each command takes an optional comma-separated list of plugin **ids**; omit it to act on every
index plugin.

| Command | Aliases | Argument | Behavior |
|---------|---------|----------|----------|
| `elasticsearch:helper:list` | `eshl`, `elasticsearch-helper-list` | — | Table of index plugin `id` + `label`. |
| `elasticsearch:helper:setup` | `eshs`, `elasticsearch-helper-setup` | `[ids]` | Calls `setup()` on each plugin — creates any missing index with its mapping/settings. |
| `elasticsearch:helper:drop` | `eshd`, `elasticsearch-helper-drop` | `[ids]` | Lists existing matching indices, then (interactive confirm) `drop()`s them. |
| `elasticsearch:helper:reindex` | `eshr`, `elasticsearch-helper-reindex` | `[ids]` | Queues managed entities for re-indexing on next cron (`context['caller'] = 'drush'`). |
| `elasticsearch:helper:truncate` | `esht`, `elasticsearch-helper-truncate` | `[ids]` | Lists existing matching indices, then (interactive confirm) `truncate()`s them (empties, keeps mapping). |

`drop` and `truncate` prompt for confirmation and skip plugins with no existing indices.

## Typical order

```bash
# 1. Create indices with the correct mappings BEFORE any content is indexed
#    (otherwise ES auto-creates loose mappings that are then left as-is).
drush elasticsearch:helper:setup

# 2. Populate. reindex only queues; run the queue to actually index.
drush elasticsearch:helper:reindex
drush queue:run elasticsearch_helper_indexing

# Inspect / tear down.
drush elasticsearch:helper:list
drush elasticsearch:helper:drop example_simple_node_index
drush elasticsearch:helper:truncate
```

Note (from README): once an index exists, `setup` leaves it untouched — drop and re-setup to apply
mapping changes.
