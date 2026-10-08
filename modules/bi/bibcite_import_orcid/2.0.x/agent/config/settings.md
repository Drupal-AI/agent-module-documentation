<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ORCID Import — install, user fields & configuration

## Install / enable
`composer require drupal/bibcite_import_orcid` (pulls `renanbr/bibtex-parser`), then enable with `bibcite`. `bibcite_import_orcid_install()` (`bibcite_import_orcid.install`):
- Creates five **user** fields if absent (bundle `user.user`):
  - `field_references` — entity_reference → `bibcite_reference`, unlimited (label "My Publications").
  - `field_orcid` — string, cardinality 1 (the researcher's ORCID id).
  - `field_author` — entity_reference → `bibcite_contributor`, unlimited.
  - `field_periodicity` — list_string, required, values `no` / `monthly` / `90days` / `annual`, default `monthly` (bio-sync cadence).
  - `field_last_sync` — string (last bio-sync date `Y-m-d`).
  Config-install also ships `field_first_name` / `field_last_name` string fields (used to build the owner's display name for author matching) and the block placement.
- Grants `view orcid import block` to the `authenticated` role.
- Places the `bibcite_import_orcid_block` block in `content`, visible on `/user/*`.
- Seeds config `orcid_sync_frequency = none`, `orcid_sync_authors = 1`.

`hook_uninstall` deletes `field_references`, `field_author`, `field_periodicity` and the block. `bibcite_import_orcid_update_8001` re-creates any missing managed field and defaults `orcid_sync_authors` to 1. Note the module also reads/writes `field_bio` (bio target) but does **not** create it — provide it yourself.

## Configuration object `bibcite_import_orcid.settings`
Edited by `Form\ModuleConfigurationForm` at `/admin/bibcite_import_orcid/config` (route `bibcite_import_orcid.admin_settings`, permission **Administer ORCID configuration**). Schema in `config/schema/bibcite_import_orcid.schema.yml`.

| Key | Type | Meaning |
|---|---|---|
| `orcid_unpub_default` | boolean | Create new references as unpublished (`status = 0`) so an editor reviews first. Read in `Import::importOrcid()`. |
| `orcid_sync_authors` | boolean | Default 1. When on, an interactive author-selection form runs before import; when off, references are attached straight to `field_references` and daily/weekly/monthly cron sync is unlocked. |
| `orcid_sync_frequency` | string | `none` / `daily` / `weekly` / `monthly` — cron cadence (only used when author-sync is off; the form only shows this select when `orcid_sync_authors` is unchecked). |
| `orcid_fetch_bio` | boolean | Enable ORCID biography import. |

Note: `ModuleConfigurationForm::submitForm()` saves only `orcid_unpub_default`, `orcid_sync_authors`, `orcid_sync_frequency` — the `orcid_fetch_bio` checkbox is rendered but **not persisted by this form** (it is read elsewhere via `\Drupal::config`). When author-sync is disabled the form also shows "Import all publications" / "Import all bios" buttons linking to `/orcid-import/import-all-works` and `/orcid-import/import-all-bios`.

## Config subscriber
`EventSubscriber\ConfigSubscriber::onConfigSave()` reacts to any save of `bibcite_import_orcid.settings` and rewrites the `user.user.default` **entity_form_display**:
- `orcid_sync_authors == 0` → show `field_references`, hide `field_author`; else show `field_author`, hide `field_references`.
- `orcid_fetch_bio == 0` → hide `field_periodicity`; else show it as `options_select`.

## Cron (`bibcite_import_orcid_cron`)
No-op when `orcid_sync_frequency == none`. Otherwise, using `\Drupal::state()` key `bibcite_import_orcid.last_sync`, it runs once per day/ISO-week/month and calls `Import::importUsersPublications()`; if `orcid_fetch_bio` is set it also calls `Import::importUsersBio()`.
