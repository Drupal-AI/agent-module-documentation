# Views Remote Data — Views plugins it ships

All are standard Views plugins in `src/Plugin/views/`. This module defines **no plugin type of
its own** — it plugs into Views' existing types.

## Query

| id | class | role |
|---|---|---|
| `views_remote_data_query` | `query/RemoteDataQuery` | replaces the SQL query. Dispatches `RemoteDataQueryEvent` + `RemoteDataLoadEntitiesEvent`; a base table opts in via `base['query_id'] = 'views_remote_data_query'`. |

Notable `RemoteDataQuery` internals: `addWhere($group,$field,$value,$operator)` and
`addOrderBy($table,$field,$order,...)` collect conditions/sorts (splitting `field` on `.`);
`ensureTable()`/`addField()` are no-op stubs required by Views handlers. Cache tag
`views_remote_data` is always present; `getCacheTags()` also merges each row's `_entity` tags.

## Property handlers (all id `views_remote_data_property`)

One handler per Views type, each configured with a **`property_path`** (dot path read out of
the result row). Added to every remote base table automatically by
`views_remote_data_views_data_alter()` as the `property` column.

| Views type | class |
|---|---|
| field | `field/PropertyField` |
| filter | `filter/PropertyFilter` |
| argument (contextual filter) | `argument/PropertyArgument` |
| sort | `sort/PropertySort` |

Shared logic is in `PropertyPluginTrait`. In config each handler carries
`plugin_id: views_remote_data_property` and `property_path: <path>` (schema in
`config/schema/views_remote_data.schema.yml`).

## Cache plugins

| id | class | notes |
|---|---|---|
| `views_remote_data_time` | `cache/RemoteDataTimeCache` | time-based; options `results_lifespan(_custom)`, `output_lifespan(_custom)`. |
| `views_remote_data_tag` | `cache/RemoteDataTagCache` | tag-based. |

Both use `RemoteDataCachePluginTrait` and are only offered on remote-data bases (restricted in
`views_remote_data_views_plugins_cache_alter()`).

## Wizard

| id | class |
|---|---|
| `views_remote_data` | `wizard/ViewsRemoteData` (derived by `Derivative/ViewsWizardDeriver`) |

Lets the Views UI "Add view" wizard scaffold a View on any remote base table (the table gets
`wizard_id: views_remote_data`).

## Rendered entity

If a base table declares `table['entity type']`, the alter hook also adds a `rendered_entity`
field (core's handler) so you can render loaded `_entity` rows in a view mode.
