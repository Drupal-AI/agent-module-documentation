<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Sync is to *content* what core's configuration management is to *config*: it exports content entities to YAML files (one file per entity, keyed by UUID), diffs them against the running site, and imports them again on another environment. It ships an admin UI under `/admin/config/development/content` and `drush content-sync:export` / `content-sync:import` commands.

---

The module reuses Drupal's serialization stack rather than inventing its own format: a `yaml` encoder plus a stack of normalizers (content entity, file, user, path alias, paragraph, plus field-item normalizers for text, image, link, timestamp and entity reference) turn an entity into a YAML document that references other entities by **UUID** instead of by numeric id. Exported files land in the content sync directory — `$settings['content_directories']['sync']` in `settings.php`, mirroring core's config sync directory — and a `cs_db_snapshot` database storage keeps the last-known state so the sync screen can show created/updated/deleted diffs. `ContentSyncManager` drives both directions: `generateExportQueue()` walks entities (optionally including dependencies) and `generateImportQueue()` orders incoming files through `ImportQueueResolver` so referenced entities are created before the entities that point at them. Imports run through `ContentImporter::importEntity()`, which looks the entity up by UUID and updates it in place (or creates it), and validates before save. Everything is batched, so large exports/imports run in a progress bar in the UI or a batched Drush run on the CLI. Files can travel three ways (`--files=none|base64|folder`): skipped, inlined into the YAML as base64, or copied alongside it. A `sync_normalizer_decorator` plugin type lets you post-process the normalized array in both directions — the shipped `id_cleaner` decorator strips serial ids/target ids so entities do not collide across environments. Four `restrict access: true` permissions gate the UI (`synchronize content`, `export content`, `import content`, `logs content`), and a dedicated `cslog` logger channel records what each run did.

---

- Move editorial content from a staging site to production without a database copy.
- Ship demo/seed content (nodes, terms, menus, blocks) inside a deployment.
- Keep a content snapshot in git so content changes are code-reviewable.
- Export a single node as YAML to reproduce a bug on another environment.
- Import a single pasted YAML document to recreate one entity quickly.
- Export a whole entity type (`--entity-types=node`) for a bulk content migration.
- Export only selected UUIDs (`--uuids=…`) to move a curated set of pages.
- Include referenced entities automatically with `--include-dependencies`.
- Carry files with the content by inlining them as base64 (`--files=base64`).
- Sync content that references files stored in a shared folder (`--files=folder`).
- Review a diff of every pending content change before importing it.
- Roll a content change forward across dev → stage → prod with the same YAML.
- Automate content deployment from CI with `drush content-sync:export`/`:import`.
- Recreate a production content set locally for debugging.
- Seed a new multisite instance with a baseline set of nodes and taxonomy terms.
- Back up a subset of content as human-readable YAML instead of a SQL dump.
- Restore an accidentally deleted node from a previously exported YAML file.
- Move paragraphs-based page content between environments intact.
- Preserve URL aliases across environments via the path alias normalizer.
- Strip environment-specific ids on import with the `id_cleaner` decorator.
- Write a custom `sync_normalizer_decorator` to rewrite domains or strip PII on export.
- Import content that originated on a different site by enabling the site-UUID bypass.
- Audit past sync runs in the module's own log screen (`/admin/config/development/content/logs`).
- Bulk-export nodes selected in a view via the *Export content* action.
- Compare the sync directory against the live site before a release.
