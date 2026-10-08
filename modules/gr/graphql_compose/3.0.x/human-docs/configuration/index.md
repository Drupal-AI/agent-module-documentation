# Configuration

GraphQL Compose has no settings page of its own. Instead, you configure a specific
GraphQL **server** through three tabs that the module adds to the server's edit
form. All of your choices are saved into a single configuration object per server,
so the whole schema is exportable and deployable as config.

## Open the GraphQL Compose server

1. Log in as a user who can administer the site's web services.
2. Go to **Configuration → Web services → GraphQL servers**
   (`/admin/config/graphql/servers`).
3. Edit the GraphQL Compose server (endpoint `/graphql`). You'll see three extra
   tabs: **Schema**, **Settings** and **Information**.

## Schema tab — choose what your API exposes

This is where you turn Drupal content into GraphQL. The tab lists every entity
type GraphQL Compose can expose (nodes always; users, media, menus, etc. once
their submodules are enabled).

- **Enable a bundle** — tick a content type (e.g. *Article*) to expose it as a
  GraphQL type. Only bundles you enable appear in the schema, so you can keep the
  API as small as you like.
- **Load by UUID** — for a content bundle you can also enable a "load one by UUID"
  query, so a client can fetch a single item by its UUID.
- **Rename a type** — optionally override the GraphQL type name for a bundle
  instead of accepting the generated one.
- **Enable fields** — for each enabled bundle, tick exactly which fields appear in
  the schema. Unticked fields stay out of the API. You can also override a field's
  schema name.

After you save, the module clears the GraphQL caches so the new schema is built.

## Settings tab — global schema toggles

These switches apply to the whole server:

- **Exclude unpublished** — hide unpublished entities from query results.
- **Expose entity IDs** — expose Drupal's internal integer IDs alongside UUIDs
  (off by default; UUIDs are the primary identifier).
- **Simple queries / Simple unions** — generate simpler query and union shapes.
- **Site information** — individually expose the site name, slogan, email, front
  page, and the 403 / 404 pages to the schema.
- **Schema description / version** — free-text strings advertised to clients so a
  front end can tell which schema it is talking to.
- **Inflection** — control the language and singular/plural rules used when the
  module names your queries (for example `article` → `articles`).

## Information tab

A **read-only** view of the schema that has been built from your choices — useful
for confirming that the types, queries and fields you expect are present before
you point a front end at `/graphql`.

## Querying the API

Once bundles and fields are enabled, send GraphQL queries to `/graphql`. Access to
the endpoint is governed by GraphQL Compose's own access check (there is no
dedicated permission to grant). If you have a GraphQL Explorer/voyager set up via
the base `graphql` module, you can browse the generated schema interactively.

## Advanced: extending the schema in code

Everything above is no-code. Developers can go further — adding custom GraphQL
types, forcing fields on or off, altering resolved values, or adding whole entity
types — through the module's plugin types and alter hooks. Those seams are
documented for agents in [`agent/plugins/plugin-types.md`](../agent/plugins/plugin-types.md)
and [`agent/hooks/hooks.md`](../agent/hooks/hooks.md).
