<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Source plugins

All classes are in `src/Plugin/migrate/source/`. Reference a plugin by its `id` in a migration's
`source.plugin`. Except `csv`, every D7 source reads from the migration's configured D7 database.

## Shared trait: `EdwSource` (`source/d7/EdwSource.php`)

Not a plugin. Mixed into most D7 sources. Provides:
- `getUrlAlias(Row, $langcode)` — queries the D7 `url_alias` table for a node/term (prefix
  `node/` or `taxonomy/term/`, resolved from `nid`/`entity_id`/`tid`), newest `pid` first; falls
  back `und` → `en` → other language, returns `"/$alias"` or NULL.
- `setUrlAlias(Row)` — sets a source property `alias` = `['alias' => …, 'pathauto' => 0]`.
- `isSkippableRow($row)` — always returns FALSE (an override point for subclasses).

## D7 entity sources (extend core migrate sources)

- **`edw_d7_node`** — `EdwNode` extends core `node` `Node`. `prepareRow()` sets the URL alias;
  `getFieldValues()` forces `revision_id = NULL` so field values are read from `field_data_FIELD_*`
  (works around missing rows in `field_revision_FIELD_*`). Adds helpers `setFieldCollectionFields()`
  (pulls `field_collection_item` field values into a source property), `getNodeName()`, `getTermName()`.
- **`edw_d7_taxonomy_term`** — `EdwTerm` extends core `Term`. `prepareRow()` resolves language
  (Entity Translation source language / i18n mode / `language_default` variable), loads Field API
  field values in the right language, finds the parent tid from `taxonomy_term_hierarchy`, flags
  forum containers via the `forum_containers` variable, honours the D7 Title module's `name_field` /
  `description_field`, and sets the URL alias.
- **`edw_d7_taxonomy_term_et`** — `EdwTermEntityTranslation` extends core `TermEntityTranslation`;
  adds URL-alias handling.
- **`edw_d7_taxonomy_term_i18n_translation`** — `EdwI18nTermTranslation` extends core `Term`; joins
  `i18n_string` + `locales_target` to expose translated `name`/`description` (via
  `getTranslatedProperty()`); ids are `tid` + `language`.
- **`edw_d7_node_entity_translation`** — `EdwNodeEntityTranslation` extends core
  `NodeEntityTranslation`; custom `query()` joins `entity_translation` + `node` + `node_revision`
  (optional `node_type` filter, excludes `und` and empty-source rows); sets URL alias.
- **`edw_d7_user`** — `EdwUser` extends core `User`. `prepareRow()` **skips uid 1**, and remaps each
  D7 role id to a D8+ role machine name by looking it up in
  `migrate_map_upgrade_d7_user_role` (with hardcoded fallbacks 1→anonymous, 2→authenticated,
  3→administrator); unknown roles are dropped. Requires that the `upgrade_d7_user_role` migration
  has already run.
- **`edw_d7_file`** — `EdwFile` extends core `file` `File`; `initializeIterator()` sets
  `publicPath` / `privatePath` / `temporaryPath` from `configuration.constants.file_*_path`
  (defaults `sites/default/files`, NULL, `tmp`).
- **`edw_d7_menu_link`** — `EdwMenuLink` extends core `MenuLink`; `prepareRow()` converts a
  `link_path` of `<void>` / `<void1>` to `<nolink>`.

## Other D7 table sources (extend `DrupalSqlBase`)

- **`draggableviews`** — `DraggableviewsStructure` selects the D7 `draggableviews_structure` table
  (id `dvid`).
- **`d7_locale_source`** — `LocaleSource` (`source/d7/LocaleSource.php`) selects `locales_source`
  joined to `locales_target`, `textgroup = 'default'`, distinct (id `lid`).
- **`d7_locale_target`** — `LocaleTarget` (`source/d7/LocaleTarget.php`) selects `locales_target`
  joined to `locales_source`, `textgroup = 'default'` (ids `lid` + `language`).

## `csv` source (`source/CSV.php`)

`CSV extends SourcePluginBase implements ConfigurableInterface` (id `csv`, `source_module =
migrate_source_csv`) — a bundled copy of the Migrate Source CSV plugin using `League\Csv\Reader`
(`Reader::createFromStream(fopen($path,'r'))`). Config keys:
- `path` (required; a relative path is prefixed with `\Drupal::root()`), `ids` (required array of
  unique string column names), `header_offset` (default 0, null = no header), `fields` (name/label
  overrides), `delimiter` (`,`), `enclosure` (`"`), `escape` (`\`) — each control char must be
  exactly 1 character, `create_record_number` (bool), `record_number_field` (default
  `record_number`). Invalid config throws `\InvalidArgumentException`; a missing file throws
  `\RuntimeException`.
