<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Easy migration example (easy_migration_example) — agent index

Bundled example submodule of **Easy Migration**. Ships four reference `EntityMigration` plugins
demonstrating a Drupal 7 → Drupal 10/11 content migration. Depends on **`easy_migration`**.
Core `^10 | ^11`. License GPL-2.0-or-later. Version 1.0.1. No routes, permissions, config, Drush
commands, or plugin types of its own — it only *provides plugin instances*. (Its `info.yml`
`description` and `package` are unfilled `@todo` placeholders in the source.)

- **The four example plugins, their annotations and SQL** → [plugins/examples.md](plugins/examples.md)
- Parent framework (plugin type, base API, Drush, generator) →
  `../../../../1.0.x/agent/start.md`

## Plugins (in `src/Plugin/EasyMigration`)

| File | id | entity_type | order | tags | Purpose |
|---|---|---|---|---|---|
| `_010_TagTermEntity` | `term_tag` | taxonomy_term | 10 | term | Migrate the D7 `tags` vocabulary. |
| `_020_UserEntity` | `user` | user | 20 | user | Migrate D7 users (pass hashes, roles). |
| `_030_PageEntity` | `page` | node | 30 | content, node | Migrate D7 `page` nodes. |
| `_040_ArticleEntity` | `article` | node | 40 | content, node | Migrate D7 `article` nodes + tags + image. |

All extend `Drupal\easy_migration\EntityMigrationBase` and implement
`EntityMigrationPluginInterface`; each defines `getIds()` / `getData($id)` / `saveEntity($data)`.
`source = "drupal7"` on all four; source SQL runs against the `easy_migration` DB connection.

## Caveats (sample code — adapt before running)

- Hard-coded legacy file path `/app/migration/files` and `public://images` / `public://pictures`.
- `_020_UserEntity` maps role IDs with a fixed dictionary (`1→anonymous … 4→content_editor`).
- Node/user plugins call `$this->migrateFileFromDrupal7(...)`, but the trait method is
  `migrateFileFromDrupal()` — fix the call (and its argument order) before use.
