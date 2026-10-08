<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The four example EasyMigration plugins

All live in `modules/easy_migration_example/src/Plugin/EasyMigration/`, extend
`EntityMigrationBase`, and read from the `easy_migration` DB connection (a legacy Drupal 7 database
you register in `settings.php`). Run them with `drush emi`; the numeric class-name prefixes plus the
annotation `order` make them execute tags → users → pages → articles.

## `_010_TagTermEntity` — id `term_tag`, order 10

- **Annotation:** `entity_type = taxonomy_term`, `tags = {term}`, `source = drupal7`.
- `getIds()`: selects `tid` from D7 `taxonomy_term_data` joined to `taxonomy_vocabulary` where
  `machine_name = 'tags'`.
- `getData($tid)`: selects `tid, vid, name, description, format, weight` for one term.
- `saveEntity()`: `isAlreadyMigrated()` → update, else load or **create** the `tags` `Vocabulary`
  (`Vocabulary::create(['vid'=>'tags','name'=>'Tags'])`), then create the term. Sets name,
  description, format `basic_html`, weight; `save()`.

## `_020_UserEntity` — id `user`, order 20

- **Annotation:** `entity_type = user`, `tags = {user}`.
- `getIds()`: `uid` from D7 `users` where `status = 1 AND uid > 1`.
- `getData($uid)`: full user row + a `GROUP_CONCAT` of `users_roles.rid` as `roles`.
- `saveEntity()`: reuses an existing account matched by `name` then by `mail`
  (`loadByProperties`), else the migrated entity, else creates one. Copies **`pass`** (the D7 hash),
  `mail`, `timezone`, created/changed/login, activates or blocks per `status`. Maps legacy role IDs
  through a fixed dictionary `['1'=>'anonymous','2'=>'authenticated','3'=>'administrator','4'=>'content_editor']`
  and `addRole()`s them. If `picture` is set, migrates it via `migrateFileFromDrupal7(...)` into
  `public://pictures` and sets `user_picture`.

## `_030_PageEntity` — id `page`, order 30

- **Annotation:** `entity_type = node`, `tags = {content, node}`.
- `getIds()`: `nid` from D7 `node` where `type = 'page'`.
- `getData($nid)`: node columns + `field_data_body` (value/summary/format) via LEFT JOIN.
- `saveEntity()`: create/update a `page` node; resolves the author with
  `getMigratedEntity($data['uid'],'user')` (falls back to uid 1). Sets created/changed/title and a
  `body` field (summary run through `strip_tags()`, format `full_html`).

## `_040_ArticleEntity` — id `article`, order 40

- **Annotation:** `entity_type = node`, `tags = {content, node}`.
- `getIds()`: `nid` from D7 `node` where `type = 'article'`.
- `getData($nid)`: node + body + `field_data_field_image` (fid/alt/title) + a `GROUP_CONCAT` of
  `field_data_field_tags.field_tags_tid` as `field_tags`.
- `saveEntity()`: like the page plugin, plus — for each CSV tag id, `getMigratedEntity($tid,
  'taxonomy_term')` and assign to `field_tags`; if `field_image_fid`, migrate the file into
  `public://images` and assign to `field_image`.

## Notes

- Every SQL statement uses named placeholders (`:tid`, `:uid`, `:nid`); no user input is
  concatenated into a query.
- These are **templates**: the `/app/migration/files` base path, the role dictionary, the
  `full_html`/`basic_html` formats, and the `migrateFileFromDrupal7()` call (trait method is
  actually `migrateFileFromDrupal()`) all need adapting to your target site before running.
