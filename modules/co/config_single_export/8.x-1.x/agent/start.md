<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration Single Export (config_single_export) — agent index

Info.yml name **Configuration Single Export**, version **8.x-1.4**. Adds an **Export** (download)
button to Drupal core's *single item* configuration export page, so one config object's YAML arrives
as a correctly named file instead of text to select out of a textarea. Depends only on core `config`.
Tagged `developer`. Core requirement `^9 || ^10 || ^11`.

## What it is

Core's page at `/admin/config/development/configuration/single/export` renders a chosen configuration
object's YAML into a read-only textarea. This module adds a submit button that turns that YAML into a
downloaded file. It has **no settings form, no permissions of its own, and no Drush commands** — it is
three small pieces of glue over core.

## How it works (source-grounded)

The whole module is one `.module` file, one route, and one controller.

- **`config_single_export.module`**
  - `hook_form_alter()` — on core's form id `config_single_export_form`, appends an **Export** submit
    button and registers `config_single_export_form_submit()` as an extra submit handler.
  - `config_single_export_form_submit()` — reads the form's `config_type`, `config_name`, and the
    already-rendered `export` YAML. Builds the object name (`system.simple` uses the name verbatim;
    otherwise `entity_type.manager` supplies the config prefix), writes `"$name.yml"` into
    `file_system` `getTempDirectory()`, and redirects to the download route with that filename.
  - `hook_file_download()` — for a `temporary://` URI, returns a `Content-disposition: attachment`
    header so core's file transfer will serve the file.
- **`config_single_export.routing.yml`** — route `config.single_export_download` at
  `/admin/config/development/configuration/single/export-download/{filename}`, requirement
  `_permission: 'export configuration'` (core's own permission for this page).
- **`src/Controller/ConfigSingleExportController.php`** — `ConfigSingleExportController extends`
  core's `ConfigController`. `downloadSingleExport($filename)` wraps the filename in a `Request` and
  delegates to core's `fileDownloadController->download($request, 'temporary')`.

## Facts an agent needs

- **Route/permission:** `config.single_export_download`, gated by `export configuration` (a
  `restrict access: true` core permission). Same gate as core's single-export UI.
- **No config, no schema:** there is no `config/` directory, no `*.permissions.yml`, no
  `*.services.yml`, no `*.install`, no `*.api.php`. Nothing to configure.
- **Where the button appears:** bottom of `/admin/config/development/configuration/single/export`.
- **Dependency:** core `config` (Configuration Manager) only; no third-party libraries.

## Related docs

- `usage.md` — plain-English summary and task phrasings.
- `human-docs/` — click-through setup guide for site builders.
