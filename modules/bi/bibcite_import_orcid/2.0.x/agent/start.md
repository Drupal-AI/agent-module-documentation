<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ORCID Import (bibcite_import_orcid) — agent index

Imports publications and biographies from the ORCID public API (`https://pub.orcid.org/v3.0`) into the Bibliography & Citation (bibcite) module, linked to Drupal user profiles.

- **Requires:** `bibcite` (Bibliography & Citation), Composer lib `renanbr/bibtex-parser`. Core `^10.1 || ^11`. Package: Omibee.
- **Not** an OAuth client — it uses the anonymous ORCID *public* API; no client id/secret, no ORCID login/callback.

## What it provides
- **User fields** (created in `hook_install`, on the `user.user` bundle): `field_orcid` (string), `field_author` (ref → `bibcite_contributor`), `field_references` (ref → `bibcite_reference`), `field_periodicity` (list_string: no/monthly/90days/annual), `field_last_sync` (string). Also expects `field_first_name`/`field_last_name`/`field_bio` (first/last shipped as config).
- **Block plugin** `bibcite_import_orcid_block` (`OrcidBlock`) — "ORCID SYNC Button", shown on `/user/*` only when the profile has an ORCID id; renders the `PrepareImport` form + a "Import Biography" link. Auto-placed on install.
- **Config** `bibcite_import_orcid.settings` (schema provided): `orcid_unpub_default`, `orcid_sync_authors`, `orcid_sync_frequency`, `orcid_fetch_bio`.
- **Services:** `bibcite_import_orcid.import_user` (`ImportUserService`, bio import), `bibcite_import_orcid.config_subscriber` (`ConfigSubscriber`, swaps profile form-display components on config save).
- **Routes** (see below) + a menu link under `bibcite.settings`.
- **hook_cron** — scheduled bulk sync when `orcid_sync_frequency` != none.
- **Drush** (`drush.services.yml` → `OrcidImportCommands`): `bibcite_import_orcid:delete_refs`, `:delete_contribs`, `:delete_all`, `:delete_users_contribs`.
- **Batch callbacks** in `bibcite_import_orcid.batch.inc`.

## Key non-service classes (plain `new`, not DI)
- `Fetch` — the ORCID HTTP client (Guzzle) + ORCID→Bibcite type map.
- `Process` — turns an ORCID work into reference data; BibTeX parse; dedup; contributor merge.
- `Import` — creates/updates references & contributors; the two "all users" controllers.

## Routes
| Route | Path | Access | Handler |
|---|---|---|---|
| `admin_config_bibcite_import_orcid` | `/admin/bibcite_import_orcid` | perm `Administer ORCID Import` | admin menu block |
| `admin_settings` | `/admin/bibcite_import_orcid/config` | perm `Administer ORCID configuration` | `ModuleConfigurationForm` |
| `import` | `/orcid-import/import/{id}` | perm `access content` | `Form\ImportForm` |
| `success` | `/orcid-import/success/{id}` | perm `access content` | `OrcidImportSuccessPageController::build` |
| `import_bio` | `/orcid-import/import-bio/{uid}` | perm `access content` | `Controller\ImportBio::build` |
| `import_all_works` | `/orcid-import/import-all-works` | perm `import all orcid works` | `Import::importUsersPublications` |
| `import_all_bios` | `/orcid-import/import-all-bios` | perm `import all orcid bio` | `Import::importUsersBio` |

Permissions (`*.permissions.yml`): `view orcid import block` (granted to `authenticated` on install), `import all orcid works`, `import all orcid bio`.

## Solution docs
- [Install, fields & config](config/settings.md) — install hook, user fields, `bibcite_import_orcid.settings` keys, config subscriber, cron.
- [Import pipeline & API](api/import-pipeline.md) — block → fetch batch → prepare form → import batch; `Fetch`/`Process`/`Import` methods; Drush.
