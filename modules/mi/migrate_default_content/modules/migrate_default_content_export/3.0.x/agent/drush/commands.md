# Drush command

`src/Drush/Commands/MigrateDefaultContentExportCommands.php` (PHP attributes; no
`drush.services.yml`).

## `migrate-default-content:export-content` (alias `mdcec`)
Exports content entities to `ENTITY_TYPE.BUNDLE.yml` files in `content_export_dir` (relative to
the parent module's `source_dir`).

Options:
| Option | Effect |
|---|---|
| `--export=` | Comma-separated entity / `entity:bundle` combos to include (e.g. `node`, `node:article`). Omit to export everything. |
| `--exclude=` | Comma-separated entity / `entity:bundle` combos to exclude. |
| `--ids=` | Comma-separated entity ids to export. |
| `--exclude-ids=` | Comma-separated entity ids to exclude. |
| `--allow-null` | Keep null field values (default drops them). |

Examples:
```
drush mdcec                                   # export all content
drush mdcec --export=node                      # all nodes
drush mdcec --export=node:article              # all articles
drush mdcec --export=node --exclude=node:article
drush mdcec --export=node --ids=1,4
drush mdcec --export=node --exclude-ids=1,4
drush mdcec --allow-null
```

Behavior notes:
- Each field is serialized by the first applicable `FieldProcessor` plugin (references →
  identifiers, files → filenames, passwords → removed, etc. — see
  [../plugins/processors.md](../plugins/processors.md)).
- `ExportEntityFilter` plugins skip entities (admin uid-1 and anonymous user by default).
- A `DEFAULT_IGNORED_FIELDS` constant removes revision/created/changed/langcode/translation
  bookkeeping fields from every export.
