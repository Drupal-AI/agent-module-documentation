<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Publications Importer (localgov_publications_importer) — agent index

**Imports operator-uploaded PDFs into LocalGov HTML publications via a config-driven Extract → Transform → Save plugin pipeline; processing runs on cron or Drush.**

- **Version:** 1.1.x (release 1.1.1)
- **Core:** ^10 || ^11
- **Configure:** `localgov_publications_importer.settings` → `/admin/config/system/localgov-publications-importer` (perm `administer imports`)
- **Upload form:** `/admin/content/imports/create` (`_entity_create_access: localgov_import`; needs `create imports`)
- **Entities:** `localgov_import` (content), `localgov_import_pipeline` (config)
- **Plugin types:** Extract / Transform / Save (attribute-defined; managers in services.yml)
- **Drush:** `localgov_publications_importer:import` (alias `lpii`)
- **Permissions:** create/view/administer/delete-own imports; create/view/update/delete/administer import pipelines.
- **Submodule:** `localgov_publications_importer_ai` (optional LLM text cleanup via the AI module's default chat provider).

**Security:** All routes permission-gated (no `_access: TRUE`, no anon endpoints). Uploads are extension-restricted to `pdf` and stored in `private://`. Reads only the local uploaded PDF — **no** request/config-driven server-side fetch (not an SSRF surface) and no outbound HTTP except the opt-in AI submodule. `unserialize()` of the pages blob restricts `allowed_classes` to Page/Image; PDF links are scheme-filtered + escaped. No TLS or hardcoded-secret issues found.

See [api/pipeline.md](api/pipeline.md) and [drush/commands.md](drush/commands.md).
