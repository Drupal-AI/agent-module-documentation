<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `skip_on_404` process plugin

Class: `Drupal\migrate_skip_on_404\Plugin\migrate\process\SkipOn404` (extends
`ProcessPluginBase`, `@MigrateProcessPlugin(id = "skip_on_404")`). Injects the `http_client`
service.

## Configuration keys

- `method` — what to do when the file does not exist:
  - `row` → throws `MigrateSkipRowException('404 - <value> does not exist')`, skipping the
    **entire record** and logging a message to the migration's message table.
  - `process` → calls `stopPipeline()`, halting only the **current property**'s pipeline
    (returns NULL for that property; the rest of the row is kept).
- `source` — as with any process plugin, the source property holding the file URL/path.

## Existence check (`checkFile()`)

- If the value is an **external** URL (`UrlHelper::isExternal()`), it performs a Guzzle
  `HEAD` request through `http_client`; any `RequestException` means "missing" → skip.
- Otherwise it treats the value as a local path and uses PHP `file_exists()`.

Works for both public and private files.

## Use it in a custom migration

```yaml
process:
  # Skip the whole row if the source file is gone.
  uri:
    -
      plugin: skip_on_404
      method: row
      source: fileurl
    -
      plugin: file_copy
      source:
        - fileurl
        - '@destination'
```

Use `method: process` instead if you only want to drop the file value but still import the
rest of the row.

## Automatic integration (no config)

`migrate_skip_on_404_migration_plugins_alter()` injects `skip_on_404` (with `method: row`,
message "File does not exist") plus a `urlencode` step into the `source_full_path` process
chain of these core migrations when present:

- `d7_file`, `d7_file_private` (Migrate Drupal UI)
- `upgrade_d7_file`, `upgrade_d7_file_private` (Migrate Upgrade)

So simply enabling the module makes the standard Drupal-7 file upgrades skip missing files;
there is nothing to configure.
