<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clinical Trials (clinicaltrials) — agent index

Imports public study records from the **ClinicalTrials.gov REST API v2** into Drupal as nodes of a
dedicated **`clinicaltrials`** content type. Fetching is **CLI-only** (Drush commands); there is no
front-end query UI and no runtime route that triggers a fetch. Package `Clinical Trial`. Core
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version **1.0.2** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`language`** (core) — declared in `.info.yml`. `node`/`menu_ui`/`user` are pulled
  in transitively by the installed config (content type + displays).
- No PHP/Composer library requirements (`composer.json` requires only `drupal/core`). HTTP uses
  core's `@http_client` (Guzzle).

## What it provides (from source)

- **Content type `clinicaltrials`** (`config/install/node.type.clinicaltrials.yml`, label
  "ClinicalTrials"). Base title field relabelled **"Nct Id"**
  (`core.base_field_override.node.clinicaltrials.title.yml`); promote defaulted off. One added field
  **`field_data`** (`field.storage.node.field_data` / `field.field.node.clinicaltrials.field_data`),
  type **`string_long`**, label "Data" — holds the **PHP-`serialize()`d `protocolSection` array** of
  each study. Default + teaser view displays render `field_data` with the `basic_string` formatter.
- **Settings form** `ClinicalTrialsSettingsForm` (`Form/ClinicalTrialsSettingsForm.php`), form id
  `clinical_trials_configuration`, editing config **`clinicaltrials.settings`**.
- **One admin route** `clinicaltrials.admin` → `/admin/config/clinical-trials` (the form),
  `_permission: 'administer clinical trials config'`. Two menu links
  (`.links.menu.yml`) under `system.admin_config`.
- **Permission** `administer clinical trials config` (`.permissions.yml`, `restrict access: true`).
- **Services** (`.services.yml`): `clinicaltrials.import_service` (`ClinicalImportService`),
  `clinicaltrials.delete_service` (`ClinicalDeleteService`), `clinicaltrials.uninstall_validator`
  (`ClinicalUninstallValidator`, blocks uninstall while any `clinicaltrials` node exists).
- **Drush commands** (`drush.services.yml`): `clinical-trial:importStudies`
  (alias `ct-import-studies`, `Commands/ImportCommands`) and `clinical-trial:deleteStudies`
  (alias `ct-delete-studies`, `Commands/DeleteCommands`).
- **`hook_uninstall`** (`clinicaltrials.install`) deletes the two state keys.

## Known defects (from source)

- `.info.yml` declares `configure: clinicaltrials.settings_form`, but **no route by that name
  exists** — the only route is `clinicaltrials.admin`. The Extend-page "Configure" link is therefore
  dangling; reach the form directly at **`/admin/config/clinical-trials`** (also linked from the
  Configuration page via the menu links). README's `/admin/config/clinical-trials/settings-form`
  path is likewise wrong.
- Import runs only under Drush: `getCtData()` calls `drush_backend_batch_process()`, so a batch
  triggered from a web context would not process.

## Solution docs

- **Settings form, config keys, content type & fields, permission/route/menu, uninstall validator** →
  [config/settings.md](config/settings.md)
- **Import & delete services, Drush commands, batch flow, ClinicalTrials.gov API call, state-based
  diff/cleanup** → [services/import-and-delete.md](services/import-and-delete.md)
