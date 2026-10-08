Views Remote Data is a developer API that lets you drive a Drupal View from remote data fetched over an API (REST, GraphQL, JSON:API client, SDK, etc.) instead of the local SQL database, by dispatching events your module answers with result rows.

---

The module registers a Views query plugin `views_remote_data_query`. Any Views base table whose views-data `base` declares `query_id: views_remote_data_query` is routed through it instead of the SQL query builder. When such a View executes, the plugin dispatches a `RemoteDataQueryEvent` carrying the view, the conditions (filters + contextual filters), sorts, limit and offset; your event subscriber calls your API, wraps each record in a `views\ResultRow`, and adds it back to the event. A second `RemoteDataLoadEntitiesEvent` lets you attach real Drupal entities to result rows (setting `$row->_entity`) so entity fields and rendered-entity output work. The module provides generic Views handlers that read arbitrary nested keys out of each row by **property path**: a `property` field, filter, argument and sort (all id `views_remote_data_property`, configured with a `property_path` like `name` or `foo.bar`), plus two cache plugins (`views_remote_data_tag`, `views_remote_data_time`) and a Views wizard (`views_remote_data`). It intentionally has **no user interface, no configuration form, and no bundled data source** — you must supply a module that (a) declares a base table via `hook_views_data()` and (b) subscribes to the two events. The shipped `tests/modules/views_remote_data_pokeapi` and `views_remote_data_test` submodules are working reference implementations.

---

- Build a View backed by an external REST API instead of the local database.
- Show data from a GraphQL endpoint as Views rows, fields and filters.
- Render results from a third-party SaaS (CRM, PIM, search service) in a View.
- Expose a remote catalogue as a filterable, pageable Views listing.
- Map arbitrary JSON keys to columns using `property_path` (e.g. `name`, `sprites.front_default`).
- Turn View filters into API query parameters via the `RemoteDataQueryEvent` conditions.
- Turn View sorts into API `order` parameters via the event's sorts array.
- Pass the View's pager limit/offset through to the remote API for server-side paging.
- Attach loaded Drupal entities to remote rows so rendered-entity and entity fields work.
- Add contextual filters (arguments) that scope a remote query by a path value.
- Bubble cache tags/contexts/max-age from the remote response into the View via the event.
- Cache raw remote results for a fixed time with the `views_remote_data_time` cache plugin.
- Invalidate remote-View output by tag with the `views_remote_data_tag` cache plugin.
- Prototype a data integration without writing a custom controller or route.
- Reuse Views' formatting, styles (table/grid/HTML list) and pager for API data.
- Provide an exposed-filter search UI over a remote dataset.
- Combine several API records into one View using property paths per field.
- Build an admin dashboard that lists remote records with Views.
- Feed a block or page display from a remote endpoint via Views.
- Use the Views wizard (`views_remote_data`) to scaffold a remote-data View.
- Migrate a hand-built API listing to the standard Views UI for site builders.
- Ship a contrib integration (e.g. a specific API) on top of this generic layer.
