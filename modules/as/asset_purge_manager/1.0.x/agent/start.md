<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Asset Purge Manager (asset_purge_manager) — agent index

An admin file-deletion tool: it recursively lists every **writable file in the public files
directory** in a paginated `tableselect` and deletes the ones a privileged user selects. Package
`Content`. **No non-core dependencies.** Core requirement `^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 1.0.1. Provides permissions and a config schema; **no** services,
plugins, entities, hooks, or Drush.

- **The purge form — the file scan, deletion/blanking behaviour, routes & permissions** →
  [forms/purge-form.md](forms/purge-form.md)
- **The settings form (files-per-page) & config object** → [config/settings.md](config/settings.md)

## What it actually is

- Two form classes in `src/Form/`, nothing else:
  - `AssetPurgeManager` (extends `FormBase`, form id `asset_purge_manager_page`) — the file
    list + delete handler, at route `asset_purge_manager.asset_purge_manager_form`
    (`/admin/content/asset_purge_manager`).
  - `ConfigForm` (extends `ConfigFormBase`, form id `asset_purge_manager_config_form`) — the
    per-page setting, at route `asset_purge_manager.admin_page`
    (`/admin/config/media/asset_purge_manager`).
- Menu/task links put the purge form under **Content** (`system.admin_content`) and the config
  form under **Configuration › Media** (`system.admin_config_media`).

## Permissions (`asset_purge_manager.permissions.yml`)

- `access Asset Purge Manager page` — required by the purge form route (view the list).
- `Asset Purge Manager` — the **delete capability**; re-checked inside `submitForm()` before any
  file is touched, and gates the visibility of the submit button in `buildForm()`.
- `administer Asset Purge Manager` — required by the config form route.
- The delete and administer permissions are declared `restrict access` (marked
  "security implications") — grant to trusted roles only.

## Mechanism (from source, `AssetPurgeManager`)

- `buildForm()` resolves the public scheme's real path via
  `file_system->realpath(config('system.file').default_scheme . '://')`, calls the static
  `dirContents()` to recurse the tree, then `array_filter(..., 'writable')` (keeps only
  `is_writable()` files). Results are paginated with `pager.manager` / `pager.parameters` using
  the `num_per_page` setting; each page slice becomes the `tableselect` `#options`, keyed by each
  file's absolute realpath.
- `dirContents()` uses `scandir()` recursively; if a directory holds an `.htaccess` containing
  `Require all denied`, its files are still listed but flagged `have_link => FALSE` (rendered as
  plain text, since the link would 403). Otherwise the filename renders as an `<a href>` to the
  file's public URL.
- `submitForm()` re-checks the `Asset Purge Manager` permission, then for each selected value
  calls `file_system->delete($path)`; if `managedFile()` (an entity query on the `file` storage
  by reconstructed `uri`) finds it in `file_managed`, it `touch($path)` to leave a zero-byte
  placeholder ("Blanked"), else it stays deleted ("Deleted").
- Selected values are the `tableselect` option keys, so Drupal core's form validation rejects any
  submitted key not present in the current page's `#options` ("submitted value … not allowed").

## Config

- One config object `asset_purge_manager.settings` with a single key `num_per_page` (integer,
  default **25**). Schema in `config/schema/`, install default in `config/install/`. See
  [config/settings.md](config/settings.md).
