<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Auto Term (eat) — agent index
**Auto-creates/updates/deletes a taxonomy term mirroring a node's title, per configured bundle→vocabulary mapping.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10
- **Depends on:** views
- **Config route:** `eat.settings` → `/admin/config/system/eat` (permission `administer site configuration`).
- **Batch route:** `eat.batch_update` → `/admin/config/system/eat/batch` (permission `access content`).
- **Plugin:** Views argument-default `eat` ("Content ID from path for EAT"). **Drush:** `eat-add-single`/`eatas`. **Table:** `{eat}` (etid, tid, vid). **Hooks:** form_alter submit, entity_delete, views_pre_build.

**Security:** OVER-BROAD ROUTE — `eat.batch_update` is gated only by `_permission: 'access content'` (effectively anonymous), but its submit handler (`BatchImport::submitForm` → `Eat::matchupEntitiesToSet`) creates taxonomy terms/rows (a mutation). See `eat.routing.yml` / `src/Form/BatchImport.php`. Restrict this route. Settings route is properly admin-gated.

See [configure/eat-settings.md](configure/eat-settings.md)