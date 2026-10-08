<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# File Temporary Validator (file_temporary_validator) — agent index

Adds a per-file-field **upload validator** that blocks an upload when a **temporary file with the
same filename** already exists (matched by **filename only — no content hashing**). Prevents the
core `filename_1` / `filename_2` rename that happens when a leftover temp file collides.

Version **1.0.0-beta4** (beta). Core `^10 || ^11`. Package *File Management*. Depends on core
**`file`**. License GPL-2.0-or-later.

## What it actually provides

- **Service** `file_temporary_validator` → `Drupal\file_temporary_validator\Service\FileTemporaryValidator`
  (`src/Service/FileTemporaryValidator.php`), constructed with `entity_type.manager` + `current_user`.
- **Validation constraint plugin** `duplicate_upload_validator`
  (`src/Plugin/Validation/Constraint/DuplicateUploadValidatorConstraint.php` +
  `DuplicateUploadValidatorConstraintValidator.php`) — used as an `#upload_validators` entry.
- **Hooks** in `file_temporary_validator.module`: a field-config-form alter (the per-field enable
  checkbox), a widget-form alter (attaches the validator), the legacy `file_temporary_validator_validate`
  callback, and `hook_help`.
- **Config schema** for the per-field third-party setting (`config/schema/…schema.yml`).
- **No routes, no permissions, no Drush, no settings page, no install/cron hooks, no submodules.**

## How it hangs together, and how to operate it

- **Everything (mechanism, the two validator paths, the enable checkbox, the duplicate query, the
  error message + its access-gated link)** → [config/settings.md](config/settings.md)

## Quick facts

- Enable it per field: *Manage fields* → edit a file field → tick **"Enable File Temporary
  Validator?"** (stored as third-party setting `enabled` under `file_temporary_validator`).
- The check is a single entity query on `filename` where `status <> PERMANENT`, excluding the
  file's own fid — cheap, filename-based, no byte work.
- On core **< 10.2.0** it attaches the legacy `file_temporary_validator_validate` callback; on
  **>= 10.2.0** it attaches the `duplicate_upload_validator` constraint. Same outcome.
- It only reports duplicates and (for users with **`access files overview`**) links to the Files
  view to delete them — it never deletes files itself.
