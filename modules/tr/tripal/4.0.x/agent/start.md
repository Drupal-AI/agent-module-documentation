<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tripal (tripal) — agent index

**A toolkit for building biological (genomic/genetic) websites: Tripal content entities, controlled vocabularies, a jobs/importer framework and Chado (PostgreSQL) integration.**

- **Version:** 4.0.x (4.0.0-alpha4) · package Tripal · PHP 8.2 · PostgreSQL
- **Core:** ^10.5 || ^11.2 · depends on `pgsql`, `views`, `file`, `path`
- **Admin:** `/admin/tripal` — dashboard, storage/extension registries, jobs, cv lookup, chunked upload, file quotas, data collections, data loaders
- **Entities:** `tripal_entity` content types; term-driven TripalStorage/TripalField
- **Plugins:** TripalImporter, TripalStorage, TripalField, TripalVocabulary, TripalPubLibrary/PubParser
- **Key subsystems:** TripalDBX (cross-DB layer to Chado), jobs engine, chunked file uploader with quotas
- **Project submodules (shipped):** `tripal_chado`, `tripal_biodb` (Task API), `tripal_layout` (auto layouts, needs field_group)
- **Permissions:** `administer tripal`, `manage tripal jobs`, `upload files`, `make files permanent`, `admin/manage tripal files`, `manage tripal data collections`, `administer/publish tripal content`, `manage tripal content types`

**Security:** admin, jobs, file and content operations are permission-gated throughout. TripalDBX uses parameterised queries against the external Chado schema; stored table definitions are deserialised with `unserialize(..., ['allowed_classes' => FALSE])`. Other `unserialize()` calls (jobs, importers, pub-search criteria) operate on admin-written records, not request data. No anonymous mutating endpoints observed.

See [configure/setup.md](configure/setup.md) and [api/framework.md](api/framework.md)
