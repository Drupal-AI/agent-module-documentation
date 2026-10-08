# Drush commands

Class `Drupal\node_export\Commands\NodeExportCommands` (`drush.services.yml`).

## Export

```
drush node-export-export [nodes] [--save=y|n]
```
Alias: `ne-export`.

- `nodes` — `all` (default) or a comma-separated list of nids (e.g. `1,2,3`).
- `--save` — `y` writes a JSON file in the site's default file scheme and prints its real path;
  `n` (default) prints the JSON to stdout.

```bash
drush node-export-export all                 # print JSON for all nodes
drush ne-export 12,15 --save=y               # write nodes 12 & 15 to a file
drush node-export-export 7 > /tmp/node7.json # capture stdout to a file
```

## Import

```
drush node-export-import <file>
```
Alias: `ne-import`.

- `<file>` — path to a JSON file previously produced by an export.
- Each node is imported via `NodeImport::import()`, honoring the `node_export.settings:node_export_import`
  strategy (`replace` / `new` / `skip`). Reports counts of imported vs not-imported nodes.

```bash
drush node-export-import /tmp/nodes.json
```

Note: the exporter uses lowercase `json` internally; the destination must already have the matching
content types (and ideally fields) or the node is skipped as not importable.
