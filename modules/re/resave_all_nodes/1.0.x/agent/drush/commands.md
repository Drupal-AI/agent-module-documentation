# Drush command

Defined in `src/Commands/ResaveAllNodesCommands.php`, registered as service
`resave_all_nodes.commands` in `drush.services.yml` (constructor arg `@entity_type.manager`,
tag `drush.command`).

| Command | Aliases | Options | Action |
|---|---|---|---|
| `resave-all-nodes` | `ran` | `--bundles`, `--chunk-size` | Re-saves every matching node in chunks, with a CLI progress bar. |

## Options

| Option | Default | Meaning |
|---|---|---|
| `--bundles` | (unset → all types) | Comma-delimited content-type machine names to resave. Parsed with `StringUtils::csvToArray`; applied as `condition('type', $bundles, 'IN')`. |
| `--chunk-size` | `250` | Nodes resaved per step (`array_chunk`). |

## Usage

```bash
# Resave every node in chunks of 250
drush resave-all-nodes
drush ran

# Resave only article and page nodes
drush resave-all-nodes --bundles=article,page

# Smaller chunks (lighter memory / slower)
drush resave-all-nodes --chunk-size=5
```

## Behavior

`resaveAllNodes()` builds the node entity query in `getQuery()`:

- The query is created with `->accessCheck(FALSE)`, so — unlike the UI form, which uses
  `accessCheck(TRUE)` — the command resaves **all** matching nodes regardless of node access.
  (Expected for a CLI maintenance task; the outer command has no permission gate.)
- If `--bundles` is empty the query has no type condition and returns every node id.
- On no matches it logs "No matching nodes found." and stops.

For each chunk it calls, via `drush_op()`,
`\Drupal\resave_all_nodes\Batch\ResaveAllNodesBatch::batchOperation($chunk, [])` — the same
routine the form uses: `Node::loadMultiple()`, `$node->save()`, plus a `->save()` of each
non-default translation of translatable nodes. It advances a `progressStart/Advance/Finish`
bar and finally logs the list of saved node ids.

Note: modern Drush core ships an equivalent generic command,
`drush entity:save node --bundle=<type>` (since 11.0.0-rc1), which can substitute for this one.
