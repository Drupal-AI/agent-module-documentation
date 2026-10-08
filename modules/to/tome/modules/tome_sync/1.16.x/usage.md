<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tome Sync serialises all Drupal content, config, and files to flat files on disk (JSON by default) and keeps that export in sync as you edit, so a whole site can be rebuilt from Git with no persistent database.

---

Tome Sync makes a Drupal site's content storable as files. `drush tome:export` writes every content entity to the content directory (`tome_content_directory`, default `../content`) as `<entity_type>.<uuid>.json`, exports config to the config sync directory, and copies managed files to the files directory (`tome_files_directory`, default `../files`). After a fresh `drush si <profile>`, `drush tome:import` rebuilds the site from those files. Once enabled, entity insert/update/delete hooks keep the on-disk export current automatically, so ordinary editing produces a committable changeset; a content-hash table (`tome_sync_content_hash`) lets `drush tome:import-partial` import only what changed. Serialization is handled by a stack of custom normalizers (entity reference, path alias, pathauto, URI, user, file, etc.) so exports are portable across environments; the encoder is JSON by default but can be switched to experimental YAML via `Settings::get('tome_sync_encoder')`. File handling goes through the swappable `tome_sync.file_sync` service — override it with `NullFileSync` in your site's `services.yml` if you symlink or externalise files instead of tracking them. There is an admin UI at `/admin/config/tome/sync` (permission `use tome sync`) for partial sync and unused-file cleanup, plus Symfony events around each export/import for custom logic. Directories are `settings.php` values; there is no config object of its own.

---

- Store all Drupal content as JSON files in Git for code-reviewed content changes.
- Do an initial full export of content, config, and files with `drush tome:export`.
- Rebuild a site from scratch on any machine with `drush si` then `drush tome:import`.
- Keep the on-disk export automatically updated as editors create/edit/delete content.
- Import only changed content/config/files with `drush tome:import-partial`.
- Move content between environments by committing and pulling the content directory.
- Export or import a single entity with `drush tome:export-content` / `drush tome:import-content`.
- Delete content or remove translations from the export with `drush tome:delete-content`.
- Remove exported files no longer referenced anywhere with `drush tome:clean-files`.
- Switch the content encoder from JSON to experimental YAML via `tome_sync_encoder`.
- Change where content/files are written via `tome_content_directory` / `tome_files_directory`.
- Symlink or externalise files by overriding `tome_sync.file_sync` with `NullFileSync`.
- Restrict UI-driven content import with the `use tome sync` permission.
- Synchronize content and files from the admin UI at `/admin/config/tome/sync/import-partial`.
- Clean up unused files from the admin UI at `/admin/config/tome/sync/clean-files`.
- Run custom logic per exported/imported entity via `tome_sync.export_content` / `import_content` events.
- React to a full export/import finishing via `tome_sync.export_all` / `import_all` events.
- Fire the import-complete event manually with `drush tome:import-complete`.
- Track what changed via the `tome_sync_content_hash` table for fast partial imports.
- Version content and config together for reproducible, database-free deployments.
- Feed the flat content store into Tome Static to generate a fully static site.
- Preserve path aliases and pathauto state across export/import via dedicated normalizers.
- Export users and their accounts portably with the user normalizer.
- Parallelize large exports/imports with `--process-count` / `--entity-count`.
