# Views Remote Data — manual setup guide

**Views Remote Data** (`views_remote_data`) is a **developer API** that lets you
build a Drupal View from data fetched over an API — REST, GraphQL, a JSON:API
client, an SDK, whatever — instead of from the local SQL database. You get to reuse
Views' familiar formatting, styles, filters, sorts and pager, but the rows come from
a remote source you supply in code.

It is deliberately a toolkit, not a turnkey feature: it has **no user interface, no
settings form, and no bundled data source**. Instead it provides a Views query
plugin and a pair of events. To make it do anything you write a small companion
module that (1) declares a Views base table pointing at this module's query plugin,
and (2) subscribes to the events, answering them with rows fetched from your API.
Generic Views handlers let you map arbitrary nested keys out of each remote record
into columns, filters, arguments and sorts using a dot-path (a "property path" like
`name` or `sprites.front_default`).

This is a module for site builders comfortable writing a bit of PHP, or for
contrib authors building a specific integration on top of it. It depends only on
core's **Views** module and needs PHP 7.4+/8. It ships two working example
submodules in its `tests/modules/` folder — one calling the live PokéAPI and one
returning fixture data with no network — that you can read as reference
implementations.

This guide is written for a **human** setting the module up. The real working
details — the events, their getters, the property handlers, and caching — are in
the sibling [`agent/`](../agent/start.md) docs, which are worth reading in full
before you build an integration.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no admin page or settings form. Once your companion module has
declared a remote base table, you build the View itself in the normal **Structure →
Views** UI (the module even provides a Views "Add view" wizard entry for remote
tables).

## How to use it

There is no click-only path; a remote-data View needs a companion module. In brief:

1. **Declare a base table** in your module's `hook_views_data()` with
   `'query_id' => 'views_remote_data_query'`. That single key routes the View
   through this module instead of SQL. Optionally declare an `entity type` so rows
   can be loaded as real entities.
2. **Subscribe to two events.** Answer `RemoteDataQueryEvent` by calling your API
   (using the event's conditions, sorts, limit and offset) and pushing each record
   back as a Views `ResultRow`. Optionally answer `RemoteDataLoadEntitiesEvent` to
   attach a real Drupal entity to each row.
3. **Build the View** in the Views UI on your new base table. Add fields, filters,
   arguments and sorts using the *property* handlers, each configured with a
   **property path** (the dot-path into your row data). Optionally set the display's
   cache plugin to `views_remote_data_time` (time-based) or `views_remote_data_tag`
   (tag-based).

The step-by-step code, the event skeletons, and the exact plugin ids are in the
[`agent/` setup docs](../agent/configure/setup.md) and
[events docs](../agent/api/events.md). The bundled `views_remote_data_test` and
`views_remote_data_pokeapi` example modules are the fastest way to see a full,
working implementation.
