<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A large framework for publishing biological data (genomics, genetics, breeding, natural history) on Drupal: it adds its own Tripal content entities and content types, a controlled-vocabulary/term system, a background jobs engine, bulk data importers, managed file uploads with quotas, and — via the Tripal Chado submodule — integration with the Chado biological-schema PostgreSQL database through the TripalDBX cross-database layer.

---

Enabling Tripal gives you `tripal_entity` content types (published biological content), a term-driven field/storage system (TripalStorage / TripalField) that maps fields to controlled-vocabulary terms, and admin tooling under `/admin/tripal`: a dashboard, storage/extension registries, a jobs manager (submit, view, cancel, rerun long-running tasks), controlled-vocabulary lookup (`cv_lookup`), a chunked file uploader with per-user quotas, and data collections. Data is loaded through TripalImporter plugins (the Data Loaders UI, `tripal.data_loaders`), and publication metadata via TripalPubLibrary/PubParser plugins. Tripal Chado connects the site to a Chado schema in PostgreSQL (hence the `pgsql` dependency) using TripalDBX, which speaks to an external schema safely — parameterised queries and, where it deserialises stored table definitions, `unserialize(..., ['allowed_classes' => FALSE])`.

Access is permission-gated throughout: `administer tripal`, `manage tripal jobs`, `upload files`, `make files permanent`, `admin tripal files`, `manage tripal files`, `manage tripal data collections`, `administer tripal content`, `publish tripal content`, `manage tripal content types`. Operationally it is a heavyweight platform (PHP 8.2, PostgreSQL 14-18, its own PHPUnit matrix and a Docker/`tripaldocker` dev environment); the shipped project also contains submodules `tripal_chado`, `tripal_biodb` (a database-focused Task API) and `tripal_layout` (auto-generated entity layouts, needs `field_group`). Several `unserialize()` calls operate on job/importer/pub-search records written by admin-level operations, not on request data.

---
- Build a genomics or genetics research website on Drupal
- Publish biological records as Tripal content entities
- Define Tripal content types backed by controlled-vocabulary terms
- Integrate an existing Chado PostgreSQL schema via Tripal Chado
- Run long tasks through the Tripal jobs engine (submit/view/cancel/rerun)
- Import bulk biological data with TripalImporter data loaders
- Look up controlled-vocabulary terms and their children (`cv_lookup`)
- Let users upload large files in chunks with per-user quotas
- Promote uploaded files to permanent storage (permission-gated)
- Manage file usage and per-user quota allocations
- Create and manage data collections of biological content
- Auto-generate entity display layouts with Tripal Layout
- Provide a database-focused Task API via Tripal BioDB
- Query an external Chado schema safely through TripalDBX
- Import and parse publications via TripalPubLibrary/PubParser plugins
- Publish/unpublish biological content in bulk
- Restrict admin/data operations with Tripal's permission set
- Monitor the platform from the Tripal dashboard with admin notifications
- Extend storage with custom TripalStorage/TripalField plugins
- Stand up a reproducible dev environment with tripaldocker
- Cross-reference terms across multiple controlled vocabularies
