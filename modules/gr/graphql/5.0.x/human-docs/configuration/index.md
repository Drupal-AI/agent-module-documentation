# Configuration

GraphQL's configuration UI is about **servers**. A server is one schema bound to
one URL path — it is the thing that turns a schema you (or a submodule) wrote in
code into a live endpoint clients can query. This page walks through creating and
tuning a server. Writing the *schema* itself is a coding task covered in the
sibling [`agent/`](../agent/start.md) docs; here we assume a schema plugin already
exists (either your own, or `composable_example` from the `graphql_composable`
submodule).

## Open the servers listing

1. Log in as a user with the **Administer GraphQL configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → GraphQL**, or navigate directly to
   `/admin/config/graphql`.

You'll see the **Servers** collection. Click **Add server** (or **Create server**)
to create one, or use the operations on an existing row to edit it, or to open
its Explorer, Voyager, and Validate tools.

## The server form, field by field

- **Label** — a human-friendly name for this server, shown in the listing.
- **Machine name** — the internal id (stored as the `name` key). It is used in
  the endpoint's route name and cannot be changed casually once queries depend on
  it.
- **Schema** — the schema plugin this server runs. Pick from the list of schemas
  available on your site. If you enabled `graphql_composable`, you'll see
  `composable_example` here; otherwise you'll see any schema you have written.
  This is the single most important choice — it decides what clients can query.
- **Schema configuration** — appears when the chosen schema has its own options.
  For a *composable* schema this is where you tick which **schema extensions** are
  active, so the schema is assembled from independent pieces. A self-contained
  schema may show nothing here.
- **Endpoint** — the URL path the server listens on, for example `/graphql`.
  After you save, the module registers a route at this path; clients then send
  their queries here with an HTTP `POST`.

## Performance and safety settings

- **Enable caching** *(on by default)* — caches GraphQL responses using Drupal's
  cache tags and contexts, so repeated queries are fast and still invalidate
  correctly when content changes. Turn it off only for a schema whose data must
  always be read live.
- **Enable query batching** *(on by default)* — lets a client send several
  operations in a single HTTP request.
- **Disable introspection** *(off by default)* — introspection lets clients ask
  the server to describe its own schema (this is what powers tooling like the
  Explorer). Leaving it on is convenient in development; many teams tick this
  **on in production** to avoid publishing the full shape of their API.
- **Query depth** — the maximum nesting depth a query may have. `0` means
  unlimited. Setting a positive cap protects the server from abusive, deeply
  nested queries.
- **Query complexity** — a cap on overall query complexity, again with `0`
  meaning unlimited. Another guard rail against expensive queries.

## Save, then rebuild caches

Click **Save**. Because saving a server registers (or changes) its endpoint
route, **run `drush cr`** (clear caches / rebuild routes) so the endpoint
actually appears. After that, the route `graphql.query.<machine-name>` is live at
your chosen path.

## Try it in the browser

From the server's row in the listing, open the **Explorer** — an in-browser
GraphiQL console where you can type a query against this server and run it. The
**Voyager** view draws the schema as an interactive graph, and **Validate**
reports schema errors. These three tools are the quickest way to confirm a server
works and to explore what it exposes.

## Servers are exportable config

Servers are configuration entities (`graphql.graphql_servers.*`), so they move
through your normal config workflow — export them from development with
`drush config:export` and import on production with `drush config:import`. That
keeps endpoint definitions consistent across environments.

## Permissions

Two permissions govern GraphQL:

- **Administer GraphQL configuration** (`administer graphql configuration`) —
  create, edit, and delete servers.
- **Bypass GraphQL access** (`bypass graphql access`) — use any server
  regardless of its per-server access restrictions. Grant this sparingly.
