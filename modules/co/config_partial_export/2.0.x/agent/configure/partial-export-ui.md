<!-- SPDX-License-Identifier: GPL-3.0-or-later -->
# The "Partial Export" admin UI

There is **no settings form** — this "configure" doc describes the export UI the module adds.
The module has no configure route in its `.info.yml` (`configure: null`); instead it adds a
**local task tab** to core's configuration single-export screen.

## Route & access

| Route | Path | Access |
|---|---|---|
| `config_partial.export_partial` | `/admin/config/development/configuration/single/config-partial-export` | permission `export configuration` |
| `config_partial.export_partial_download` | `/admin/config/development/configuration/single/partial-export-download` | permission `export configuration` |

`export configuration` is **core's** permission (from the `config` module). This module defines
no permissions of its own. The tab appears as **"Multiple items"** under *Configuration →
Development → Configuration synchronization → Export* (task `config_partial.export_partial`,
parent `config.export`).

## What the form does (`ConfigPartialExportForm`)

1. It compares **active** config against the config **snapshot** storage
   (`config.storage.snapshot`) and lists every object that differs in a `tableselect`.
2. Tick the objects you want; optionally tick **"Add system.site info"** to include
   `system.site` (the site UUID) in the export.
3. Click **Export**. The selected objects' raw data are written into a gzip tarball
   `config_partial.tar.gz` in the temp directory, and you are redirected to the download route,
   which streams it as `config_partial-<hostname>-<Y-m-d-H-i>.tar.gz`
   (filename set by `hook_file_download()` in `config_partial_export.module`).
4. Your selection (the checked items + the system.site flag) is remembered **per user** in State
   under the key `config_partial_export_form` and pre-checked next time.

To apply an exported tarball, unpack its `.yml` files into your module's `config/install`
directory (or the sync directory) and import.

## Note on the change list

The form only shows objects that differ from the **snapshot** taken at the last import. If
nothing has changed since then, the table is empty. For the equivalent from the CLI use
`drush cpex --changelist` (see [../drush/cpex.md](../drush/cpex.md)).
