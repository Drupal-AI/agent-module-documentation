# Views Remote Data — agent index

Developer API to power a **View from remote data** (an API) instead of SQL. No UI, no config
form (`configure: null`). You wire it up by (1) declaring a Views base table with
`query_id: views_remote_data_query` and (2) subscribing to two events that return rows.

- **Register a base table, build a remote-data View, use the `property` field/filter/argument/
  sort with `property_path`, cache plugins, the wizard** →
  [configure/setup.md](configure/setup.md)
- **The two events you must answer (`RemoteDataQueryEvent`, `RemoteDataLoadEntitiesEvent`),
  their getters, adding rows and cache metadata** → [api/events.md](api/events.md)
- **The Views plugins this module ships (query, property handlers, caches, wizard) and their
  ids** → [plugins/views.md](plugins/views.md)

Key facts:
- Query plugin id: `views_remote_data_query` (`RemoteDataQuery`).
- Events: `Drupal\views_remote_data\Events\RemoteDataQueryEvent` (add rows here) and
  `RemoteDataLoadEntitiesEvent` (attach `$row->_entity`).
- Property handlers (field/filter/argument/sort) share id `views_remote_data_property`,
  configured with `property_path` (dot path into the row, e.g. `name`, `foo.bar`).
- Cache plugins: `views_remote_data_time`, `views_remote_data_tag`.
- No bundled data source; `tests/modules/views_remote_data_pokeapi` and
  `views_remote_data_test` are reference implementations.
