<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Easy migration example is the bundled reference submodule of Easy Migration: four working `EntityMigration` plugins that port Drupal 7 tags, users, pages, and articles into a Drupal 10/11 site.

---

Enabling `easy_migration_example` registers four plugins under `src/Plugin/EasyMigration` that appear in `drush easy_migration:status` and run with `drush easy_migration:migrate`. They demonstrate the intended pattern — `getIds()` selects source primary keys from a legacy Drupal 7 database, `getData($id)` pulls one row with plain SQL, and `saveEntity($data)` creates or updates the destination Drupal entity — and they show the correct execution `order` so referenced entities migrate first (tags → users → pages → articles). They are meant to be copied into your own module and adapted, not run verbatim against production: the file paths (`/app/migration/files`), the role-id dictionary, and the `migrateFileFromDrupal7()` call all assume a specific legacy setup and must be edited first. The submodule depends on `easy_migration` and provides no routes, permissions, or config of its own.

---

- Learn the Easy Migration plugin pattern from complete, runnable examples instead of from the abstract base class alone.
- Copy `_010_TagTermEntity` as a template for migrating a Drupal 7 taxonomy vocabulary (auto-creates the `tags` vocabulary if missing, sets name/description/format/weight).
- Copy `_020_UserEntity` to migrate Drupal 7 users, preserving password hashes, mail, timezone, status, created/login timestamps, and mapping legacy role IDs via a dictionary.
- Copy `_030_PageEntity` to migrate Drupal 7 `page` nodes, remapping authorship to already-migrated users and stripping tags from the summary.
- Copy `_040_ArticleEntity` to migrate Drupal 7 `article` nodes together with their tag references and an image file.
- See how the annotation `order` (10/20/30/40) sequences dependent migrations so terms and users exist before the nodes that reference them.
- See how `getMigratedEntity()` is used to resolve a source author/term ID to the migrated destination entity.
- See how `isAlreadyMigrated()` makes each `saveEntity()` idempotent (update-in-place on re-run).
- Use the example SQL as a starting point for your own `getIds()` / `getData()` queries against a legacy schema.
- Test the full `drush emi` / `drush emrollback` cycle end-to-end against a sample Drupal 7 database.
- Understand how file/image migration is wired into a node migration before writing your own.
