# Views Remote Data — building a remote-data View

There is no settings form. A remote-data View needs two things from an implementing module.

## 1. Declare a base table (`hook_views_data()`)

The base table's `base` array must set `query_id: views_remote_data_query`. That single key is
what routes the View through this module instead of SQL.

```php
function mymodule_views_data(): array {
  $data = [];
  $data['my_remote_source']['table']['group'] = 'My remote source';
  $data['my_remote_source']['table']['base'] = [
    'title' => 'My remote source',
    'query_id' => 'views_remote_data_query',
  ];
  // Optional: make rows loadable as entities / rendered-entity field.
  // $data['my_remote_source']['table']['entity type'] = 'node';
  return $data;
}
```

`views_remote_data_views_data_alter()` (in `views_remote_data.views.inc`) then automatically
adds, to every such base table:
- a **`property`** column exposing the `views_remote_data_property` field/filter/argument/sort
  handlers, and
- a **`rendered_entity`** field *if* the table declared an `entity type`.
It also sets `wizard_id: views_remote_data` on the table so the Views UI wizard can scaffold it.

## 2. Subscribe to the events

Answer `RemoteDataQueryEvent` with rows and (optionally) `RemoteDataLoadEntitiesEvent` with
entities — see [../api/events.md](../api/events.md).

## 3. Configure the View (config)

A View on such a base table stores handlers with `plugin_id: views_remote_data_property` and a
`property_path`. Minimal field handler in `views.view.*` config:

```yaml
base_table: my_remote_source
display:
  default:
    display_options:
      fields:
        title:
          id: title
          table: my_remote_source
          field: property
          plugin_id: views_remote_data_property
          property_path: name        # dot path into each result row
```

The same shape applies to `filters`, `sorts`, and contextual `arguments` (each
`plugin_id: views_remote_data_property` + `property_path`). A filter's `value`/`operator`
arrive in the query event's `conditions`; a sort's `order` arrives in its `sorts`.

## 4. Caching (optional)

Set the display's cache plugin to one of:

| Cache plugin id | Effect |
|---|---|
| `views_remote_data_time` | time-based caching of raw results + rendered output (configurable lifespans). |
| `views_remote_data_tag` | tag-based caching (invalidated by the tags your event bubbles). |

```yaml
      cache:
        type: views_remote_data_time
        options:
          results_lifespan: 3600
          output_lifespan: 3600
```

These two plugins are only offered on bases whose `query_id` is `views_remote_data_query`
(restricted in `views_remote_data_views_plugins_cache_alter()`).

## Reference implementations

- `tests/modules/views_remote_data_pokeapi` — calls the live PokéAPI (network).
- `tests/modules/views_remote_data_test` — returns rows from a JSON fixture (no network);
  base tables `views_remote_data_test_simple`, `views_remote_data_test_entity_test`.
