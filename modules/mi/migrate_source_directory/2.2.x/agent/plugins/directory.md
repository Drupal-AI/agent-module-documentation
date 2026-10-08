# Directory migrate source plugin (`plugin: directory`)

Reads one or more filesystem directories and yields **one migration row per file**.
Each row carries the file's path and stat metadata as source properties, which the
process pipeline maps onto a file, media, or content entity.

- Class: `Drupal\migrate_source_directory\Plugin\migrate\source\Directory`
  (extends `\Drupal\migrate\Plugin\migrate\source\SourcePluginBase`).
- Annotation: `@MigrateSource(id = "directory", source_module = "migrate_source_directory")`.
- Requires the core `migrate` module. Used only from a migration YAML `source:` block;
  no admin UI.

## Configuration keys

Set these under the migration's `source:` mapping.

| Key | Type | Default | Required | Behavior |
|-----|------|---------|----------|----------|
| `directory` | string or list of strings | — | Yes | Absolute directory path(s) to scan. Each is validated with `is_dir()` in the constructor; an invalid/missing path throws `MigrateException`. Subdirectories are recursed into. |
| `file_mask` | string (PCRE regex) | none | No | Applied to each file's full pathname via `\RegexIterator` (`USE_KEY`); only matching files are yielded. Example: `'/(.*\.(mp3|m4a|wav)$)/i'`. |
| `recurse_level` | int | `-1` | No | Max recursion depth, passed to `\RecursiveIteratorIterator::setMaxDepth()`. `-1` = unlimited. Must be numeric or the constructor throws. |
| `id_prefix` | string | `''` | No | Prepended to every row's `sourceID`. Use it to disambiguate identically named files scanned from different directories. |
| `file_must_contain_string` | string or list of strings | `[]` | No | A file is included only if its full contents contain **every** listed substring (`strpos`, contents read with `file_get_contents`). Text-file oriented; skips non-matching files. |
| `track_changes` | bool | unset | No | Core `SourcePluginBase` option (not defined by this module). Set `track_changes: true` so a re-import re-processes files whose source properties changed. |

Notes / edge cases (from the constructor):
- Empty or absent `directory` throws `MigrateException('The "directory" configuration option is required.')`.
- Legacy alias: if `directory` is empty but `urls` is set, `urls` is copied into `directory` (backward compatibility with pre-`directory` configs).
- A single string is normalized to a one-element list, so `directory: /path` and `directory: [/path]` both work.

## Source fields (row properties)

Row ID (`getIds()`): **`sourceID`**, type `string`.

| Property | Source | Description |
|----------|--------|-------------|
| `sourceID` | `id_prefix` + pathname relative to the scanned `directory` | Unique row ID (the file path relative to its directory, with the leading directory stripped). |
| `source_file_basename` | `SplFileInfo::getBasename()` | Base name of the file. |
| `source_file_extension` | `getExtension()` | File extension. |
| `source_file_filename` | `getFilename()` | Filename with extension. |
| `source_file_mtime` | `getMTime()` | Unix mtime the file was last modified. |
| `source_file_path` | `getPath()` | Directory of the file, **without** the filename. |
| `source_file_pathname` | `getPathname()` | Full path to the file (directory + filename). |
| `source_file_realpath` | `getRealPath()` | Canonical absolute path to the file. |
| `source_file_size` | `getSize()` | File size in bytes. |
| `source_file_type` | `getType()` | File type (`file`, `dir`, `link`, ...). |

Operational tip: to copy/read the actual file, use `source_file_realpath` or
`source_file_pathname` (both include the filename). `source_file_path` is the directory
only and is **not** a usable file path for `file_copy`/`file_get_contents`.

## Example: import files as File entities

```yaml
id: directory_mp3
label: 'Import audio files'
source:
  plugin: directory
  track_changes: true
  constants:
    dest_dir: 'public://'
  directory:
    - /path/to/files/for/import
    - /path/to/additional_files
  # Only .mp3/.m4a/.wav files.
  file_mask: '/(.*\.(mp3|m4a|wav)$)/i'
  recurse_level: -1
process:
  # Destination URI = public://<filename>.
  uri_dest:
    - plugin: concat
      delimiter: /
      source:
        - constants/dest_dir
        - source_file_filename
    - plugin: urlencode
  uri:
    plugin: file_copy
    source:
      - source_file_realpath   # copy FROM the file on disk
      - '@uri_dest'            # copy TO public://<filename>
destination:
  plugin: 'entity:file'
```

Reference the imported files from other migrations by the `sourceID` source property
(the path relative to `source.directory`).

## Example: import file contents as nodes

The plugin exposes file paths and metadata but **not** file contents. To import what is
inside each file, read it in `hook_migrate_prepare_row()` (or in a `prepareRow()` method
of a subclass of `Directory`) and set extra source properties.

```yaml
id: markdown_import
label: 'Import markdown files'
source:
  plugin: directory
  track_changes: true
  directory:
    - /path/to/files/for/import
  # All .md files except README.md.
  file_mask: '/^(.*\.md)(?<!README\.md)$/i'
  recurse_level: -1
process:
  type:
    plugin: default_value
    default_value: page
  title: title            # set in hook_migrate_prepare_row()
  body/value: body        # set in hook_migrate_prepare_row()
  body/format:
    plugin: default_value
    default_value: markdown
  changed: source_file_mtime
destination:
  plugin: 'entity:node'
```

```php
use Drupal\migrate\Row;
use Drupal\migrate\Plugin\MigrateSourceInterface;
use Drupal\migrate\Plugin\MigrationInterface;

/**
 * Implements hook_migrate_prepare_row().
 */
function my_module_migrate_prepare_row(Row $row, MigrateSourceInterface $source, MigrationInterface $migration) {
  if ($migration->id() !== 'markdown_import') {
    return;
  }
  $content = file_get_contents($row->getSourceProperty('source_file_realpath'));

  // First line, when it starts with '#', becomes the title.
  $title = strtok($content, "\n");
  if (str_starts_with($title, '#')) {
    $row->setSourceProperty('title', trim(substr($title, 1)));
    $content = trim(substr($content, strpos($content, "\n") + 1));
  }
  $row->setSourceProperty('body', $content);
}
```

## Running

Register the migration (e.g. via a `migrate_plus` config entity or a module's
`migrations/` directory) and run it with the standard Migrate tooling
(`drush migrate:import <id>`, `drush migrate:status`). The directory is scanned when the
iterator initializes at run time, so file counts reflect the directory's state at that
moment.

## Config-schema note

`config/schema/migrate_source_directory.schema.yml` declares `migrate.source.dir` with
keys `urls`, `file_extensions`, `recurse_level`. That type name does not match the plugin
id (`directory`, which would map to `migrate.source.directory`) and its key list does not
match the plugin's actual options, so it does not validate real source config. Treat the
**Configuration keys** table above as authoritative.
