# GraphQL — manual setup guide

**GraphQL** (`graphql`) is a framework for building GraphQL servers on a Drupal
site. GraphQL is a query language that lets a client ask for exactly the data it
wants — no more, no less — in a single request, and get back a predictable,
typed response. This module lets you expose your Drupal content and data model
through one or more GraphQL endpoints, which is a common way to feed a decoupled
("headless") front end built in React, Vue, Next.js, or a mobile app.

It is important to understand what this module *is* before you install it: it is a
developer framework, not a turnkey feature. Enabling it gives you the building
blocks — a settings screen for creating "servers", a set of plugin types, and the
underlying query engine (the bundled `webonyx/graphql-php` library) — but **no
working endpoint out of the box**. A GraphQL endpoint only becomes useful once
someone defines a *schema* (the set of types and fields clients can query) in
code. You either write that schema yourself, or enable the bundled
`graphql_composable` example submodule, which ships a ready-to-try schema
(`composable_example`) so you can see a real endpoint working end to end.

The module depends on the **Typed Data** module (`typed_data`), and it requires
PHP 8.1+ and Drupal 10.4 or 11. Two optional submodules ship with it:
**GraphQL Composable** (`graphql_composable`), the example/learning schema, and
**GraphQL File Validate** (`graphql_file_validate`), which adds file-upload
validation to GraphQL mutations.

This guide is written for a **human** setting the module up through the admin UI
and the code editor. If you want terse, token-cheap references for an AI coding
agent — the schema plugin types, the server config entity keys, the service
names — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and decide whether to enable the example submodule.
2. [Configuration](configuration/index.md) — create and tune a GraphQL server
   (its schema, endpoint path, caching, and safety limits), field by field.

## Where it lives in the admin menu

Once enabled, GraphQL adds a **GraphQL** section to the admin configuration area
at **Configuration → Web services → GraphQL** (`/admin/config/graphql`). This is
where you create and manage *servers* — each server is one schema bound to one
URL path. From a server's row you can open the built-in in-browser **Explorer**
(a GraphiQL query console), the **Voyager** schema graph, and a **Validate**
report, all handy for exploring and debugging a schema.

## How to use it

The whole system revolves around the **server**. A server names a schema plugin,
stores that schema's configuration, and declares an endpoint path such as
`/graphql`. When you save a server, the module registers a live JSON route at
that path, so clients can immediately `POST` GraphQL queries to it. Building the
schema those servers run is a coding task: you write a Schema plugin (or, more
commonly, use the built-in *ComposableSchema* plus one or more SchemaExtension
plugins), pairing SDL type definitions (`.graphqls` files) with resolvers that
pull data through small reusable DataProducer steps. The [Configuration](configuration/index.md)
page covers the server settings you manage in the UI; the sibling
[`agent/`](../agent/start.md) docs cover the code side (schema, extension, and
data-producer plugins) in detail.
