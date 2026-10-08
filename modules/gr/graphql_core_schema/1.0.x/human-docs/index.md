# Graphql Core Schema — manual setup guide

**Graphql Core Schema** (`graphql_core_schema`) automatically generates a fully
configurable GraphQL schema from Drupal's own entity and field system, on top of
the contrib **GraphQL** module. Rather than hand-writing SDL and resolvers for
every content type, you pick which entity types and fields to expose and switch on
ready-made schema extensions (entity query, routing, menus, views, user login, and
more). It's the successor to the old `graphql_core` module and is aimed at
decoupled / headless Drupal.

It registers a schema plugin called **Core Composable Schema**. You create a
GraphQL *Server* (from the GraphQL module), select this schema, and then configure
it entirely through that server's form: choose entity types, choose the fields to
expose per type, enable schema extensions, and enable the Views you want to expose.
The module builds matching GraphQL types and interfaces that mirror core, and
centralises resolution.

Security is a first-class concern here, and the defaults are **fail-closed**. The
default resolver enforces `view` access on every entity and field item, and entity
queries run with access checking on — so a client only ever sees what the current
session may view, for anonymous and authenticated users alike. In fact many entity
types return a *neutral* access result and therefore aren't resolved at all unless
your site adds an access hook to explicitly grant access. The one place to be
careful is **custom** field resolvers you write in your own extensions: those
bypass the default resolver's access filtering, so you must perform access checks
yourself.

This guide is written for a **human** setting things up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (the GraphQL
   module is required), enable the module, and pick any sub-modules you need.

## Where it lives in the admin menu

Graphql Core Schema has **no settings page of its own**. You configure it through
the GraphQL module's server:

- **Configuration → Web services → GraphQL** (`/admin/config/graphql`) — add or
  edit a **Server**, then select **Core Composable Schema** and configure it there.

Endpoint access is governed by the **GraphQL module's** own permissions (such as
"execute arbitrary GraphQL requests" or persisted queries), not by this module —
which defines no permissions of its own.

## How to use it

1. Install and enable this module and the GraphQL module (see
   [Installation](installation/index.md)), plus any sub-modules whose extensions
   you want.
2. Go to **Configuration → Web services → GraphQL → Add server**.
3. In **Schema**, choose **Core Composable Schema**. Set an endpoint path (e.g.
   `/graphql`) and the usual GraphQL server options.
4. Configure the schema on the same form:
   - Enable the **schema extensions** you need (see the table below).
   - Enable any **Views** you want exposed (via the Views extension).
   - Choose the **entity types** to expose, and the **fields** per type. Nothing is
     exposed until you select it — an empty schema is tiny by design.
5. Save. Then query your endpoint.

> **Production tip:** turn **off** GraphQL's development mode in production. The
> generated schema and extensions are then cached — a large performance win.
> Re-enable it only while actively editing the schema, and clear caches after SDL
> or resolver changes.

### Bundled schema extensions

Enable these per server as needed. A few highlights (see the
[`agent/` extensions docs](../agent/extend/extensions-and-submodules.md) for the
full list): `entity_query` (`entityById` / `entityQuery` with filter/sort/range),
`routing` (resolve a URL to its entity), `menu`, `breadcrumb`, `views` (run a
configured View), `image` (image-style derivatives), `render_field_item`
(`viewField` / `viewFieldItem` rendered markup), `user` (`currentUser`,
`hasPermission`, `hasRole`), and `user_login` (login/logout/password mutations).

### Sub-modules (enable separately)

The project ships fourteen optional sub-modules that integrate contrib projects or
add niche features — for example `graphql_form_schema` (entity create/edit
mutations), `graphql_security` (route-level access checks on GraphQL endpoints),
`graphql_metatag_schema`, `graphql_media_oembed_schema`, `graphql_debugging`, and
`graphql_messenger`. Enable only the ones you need; each is a thin schema extension
over the named project. The full list is in
[Installation](installation/index.md).

> **Write access:** `graphql_form_schema` exposes mutations that create and edit
> entities. They still go through Drupal form processing and entity access, but
> only expose them on servers whose clients you trust to write.
