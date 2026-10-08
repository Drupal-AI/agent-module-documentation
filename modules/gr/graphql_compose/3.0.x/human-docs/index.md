# GraphQL Compose — manual setup guide

**GraphQL Compose** (`graphql_compose`) is a no-code toolkit for building a clean
GraphQL API out of your Drupal content. Instead of hand-writing schema definition
language (SDL) and resolvers, you tick which entity types, bundles and fields to
expose, and the module generates the GraphQL types, queries and resolvers for you.
The result is a stable, "Drupalism-free" schema that a decoupled front end
(Next.js, Nuxt, Gatsby, Astro, a mobile app, …) can query at `/graphql`.

It builds on top of the base **GraphQL** module (`drupal/graphql` 5.x): GraphQL
Compose ships its own GraphQL **server** and schema plugin, and everything you
turn on is stored as ordinary Drupal configuration, so the exposed schema is
exportable and deployable like any other config. It requires PHP 8.1+, the
`graphql` and `node` modules, and the `doctrine/inflector` library (installed
automatically by Composer).

The base module exposes nodes; a large family of optional submodules extends the
schema to other parts of Drupal — **Users**, **Menus**, **Routes** (resolve
content by URL/path, redirects, breadcrumbs), **Views** (expose Views as GraphQL
queries), **Edges** (Relay-style cursor pagination), **Blocks**, **Comments**,
**ECK**, **Image Styles**, **Metatags**, **Layout Builder** and **Layout
Paragraphs**. Enable only the ones your front end needs; each one registers itself
with the server automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the base
   module, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the server's Schema / Settings /
   Information tabs, field by field, for choosing what your API exposes.

## Where it lives in the admin menu

GraphQL Compose has **no settings page of its own**. You configure a specific
GraphQL **server** through tabs on its edit form under **Configuration → Web
services → GraphQL servers** (`/admin/config/graphql/servers`). Once the module is
enabled, editing the GraphQL Compose server shows three extra tabs — **Schema**
(enable entity types, bundles and fields), **Settings** (global toggles) and
**Information** (a read-only view of the built schema). The API endpoint itself is
`/graphql`. See [Configuration](configuration/index.md) for a walkthrough.
