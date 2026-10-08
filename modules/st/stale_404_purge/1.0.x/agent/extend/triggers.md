<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stale 404 Purge — trigger matrix & integration

## Activation
1. `composer require drupal/purge` and configure a purger + queue for your reverse proxy/CDN.
2. Enable the `stale_404_purge` queuer at `/admin/config/development/performance/purge`.
3. Without Purge configured, events are detected and logged only (a notice), nothing is purged.

## Triggers → purged paths
| Hook | Condition | Purged |
|---|---|---|
| `hook_node_insert` | node published (first publish) | `/node/{nid}` + current alias |
| `hook_node_presave` | existing node unpublished→published | canonical + current alias |
| `hook_path_alias_insert` | aliased node published | new alias path |
| `hook_path_alias_update` | — | old alias always; new alias if target reachable |
| `hook_entity_delete` (redirect) | redirect deleted | source path (+ alias if `/node/{nid}`) |
| `hook_file_insert` | permanent public file | public file URL |
| `hook_file_update` | URI changed | public file URL |

## Out of scope (by design)
- Full cache flushes and broad cache-tag invalidation.
- Redirect updates (only deletes).
- Private files (served via access-controlled download controller, not publicly cacheable).

## Extending
`AffectedPathResolver` centralises path resolution; `PurgeDispatcher::dispatch(array $paths)` enqueues them. Both are injectable services you can reuse from custom code.
