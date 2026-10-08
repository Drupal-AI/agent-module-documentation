<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# YASM statistics services & data model

All counts are gathered by four services; controllers only assemble render arrays from them.

## `yasm.entities_statistics` — `Services\EntitiesStatistics`

The primary counter, built on the **entity query API** (not raw SQL). Injects `entity_type.manager`.

- `count($entity_id, array $conditions = [])` — `getStorage($entity_id)->getQuery()`, applies each
  condition (either `key => value`, or a `['key','value','operator']` triple), `accessCheck(FALSE)`,
  returns `->count()->execute()`. `accessCheck(FALSE)` is intentional: these are admin aggregate
  reports and access is enforced at the route/permission layer, not per row.
- `aggregate($entity_id, $aggregates, $group_by, $conditions)` — `getAggregateQuery()` for MIN/MAX/
  COUNT etc. (e.g. `getFirstDateContent()` uses `['created' => 'MIN']`).
- `getEntitiesInfo()` / `getEntityAndBundlesInfo()` — walks all `ContentEntityType` definitions and
  counts each entity and its bundles (used by the Entities page and reports).

Conditions are passed as bound entity-query conditions — **no string concatenation**, so there is no
SQL-injection surface even though `date_filter`/year values from the request feed into them (values
also pass through `getYearFilter()`/`getIntervalFilter()` in `YasmBuilder`, which build integer
timestamp bounds via `strtotime`).

## `yasm.users_statistics` — `Services\UsersStatistics`

Injects `@database`. One method `countUsersByEmailDomain(?array $uids)` runs a parameterized query
(`SELECT count(DISTINCT uid), SUBSTRING_INDEX(mail,'@',-1) … WHERE uid > 0 [AND uid IN (:uids[])]
GROUP BY domain`). The `:uids[]` array placeholder is bound, not interpolated.

## `yasm.groups_statistics` — `Services\GroupsStatistics`

Injects `@database` + `@entity_type.manager`. Group-scoped counters: `countGroupsByUser`,
`countContents[ByBundle]`, `countMembers[ByRole|ByAccess]`, `countComments`, `countFiles`,
`countWebformSubmissions`, `countUsersByEmailDomain`, and batch variants `countContentsAllGroups` /
`countMembersAllGroups`. Every query is parameterized (`:id`, `:type`, `:uid`, `:mindate`,
`:maxdate`, `:ids[]`, `:types[]`). The **table name** (`group_relationship_field_data` vs.
`group_content_field_data`, and the roles table) is chosen by `GroupVersionHelper` from hardcoded
constants — never from input. See [integrations.md](integrations.md).

## `yasm.datatables` — `Services\Datatables`

Injects `@language_manager` + `@http_client`. `getLocale()` maps the current Drupal langcode to a
DataTables i18n filename (hardcoded `getLocaleFilename()` map, 80+ languages) and, if found, does a
Guzzle GET to `https://cdn.datatables.net/plug-ins/2.3.7/i18n/{file}.json` to confirm the file
exists, returning the URL for the front-end. The CDN host and path are constant and the filename
comes from a fixed map (not the request), so this is not a request-driven fetch. Default TLS
verification applies. Failures are swallowed (returns `''`).

## `yasm.builder` — `Services\YasmBuilder`

Render-array helper (no data access): `card()`, `panel()`, `columns()`, `table()` (`#type => table`,
so cell values — node titles, usernames, labels — are auto-escaped by the table theme), `title()`
and `picto()` (both use `FormattableMarkup` with `@placeholder` args, so interpolated values are
escaped), `infoMessage()`, year links, `getSectionLinks()` (access-aware tab list), and time-window
helpers `getLastMonths()` / `getYearFilter()` / `getIntervalFilter()`.

## Data-model constants — `YasmEntityDefinitions`

Central lists used by reports and the mailer: `ENTITIES_WITH_CREATED` (entity → bundle type),
`ENTITIES_WITHOUT_DATE` (`taxonomy_term`), `ENTITY_EXTRA_CONDITIONS` (e.g. users exclude uid 0),
`ENTITY_LABELS`, `ENTITY_MODULES` (entity → required module). Reports skip any entity whose module
is disabled.

## Caching

Pages set cache tags (`{entity}_list`), contexts (`languages`, `user.permissions`, `url.query_args`,
`user`) and a 24h (`86400`) or 1h max-age. `YasmBuilder::infoMessage()` renders the "counts refresh
automatically; aggregates may take 24h" notice as inline markup rather than via `messenger` (a
messenger message would defeat the page cache).
