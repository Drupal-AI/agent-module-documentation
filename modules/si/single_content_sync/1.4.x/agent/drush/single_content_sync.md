# single_content_sync — drush

Commands defined in `\Drupal\single_content_sync\Commands\ContentSyncCommands` (registered via
`drush.services.yml`).

## `content:export [entityType] [outputPath]`

Exports content of an entity type to `DRUPAL_ROOT/scs-export` by default.
- `entityType` (arg 1, default `node`) — e.g. `taxonomy_term`, `block_content`.
- `outputPath` (arg 2) — output dir relative to Drupal root (created if missing).

If exactly one entity is selected and `--assets` is not used, a single `.yml` is written;
otherwise a `content-bulk-export-<date>.zip` is written.

Options:
| Option | Effect |
|---|---|
| `--translate` | Include translated content. |
| `--assets` | Bundle referenced assets (forces ZIP output). |
| `--all-content` | Export all entities of all allowed types (overrides `--entities` / `--bundle`). |
| `--dry-run` | Print the resulting file path without exporting. |
| `--entities="1,4,7"` | Only these entity ids or UUIDs (combine with `entityType`). |
| `--bundle="article"` | Only this bundle (nodes/taxonomy). |

Only content allowed in the settings form (`allowed_entity_types`) is exported; if nothing
matches, the command warns and exits.

Examples:
```
drush content:export
drush content:export block_content ./export-folder
drush content:export node /relative/output/path --entities="1,4,17" --translate --assets --bundle="article"
drush content:export --all-content --assets
```

## `content:import <path>`

Imports content from a file at `path` (relative to Drupal root). Required arg.
- `.zip` files are handled as a bundle (content + assets); anything else is treated as a YAML file
  via the importer's `importFromFile()`.

```
drush content:import export-folder/content-bulk-export.zip
drush content:import scs-export/article-123.yml
```
