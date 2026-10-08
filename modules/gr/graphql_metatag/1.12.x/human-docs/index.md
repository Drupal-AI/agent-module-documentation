# GraphQL Metatag — manual setup guide

**GraphQL Metatag** (`graphql_metatag`) exposes the output of the **Metatag** module
through a GraphQL schema, so a decoupled front end can render exactly the same `<meta>`
tags Drupal would have printed. It adds GraphQL fields for an entity's metatags, for an
arbitrary URL's metatags, and for Schema.org JSON-LD — letting a React/Next.js or
static-site build pull SEO data in the same query as the content itself, without
duplicating the SEO configuration.

It's a developer-focused module: it's purely a bundle of GraphQL plugin classes with
**no configuration, no permissions, no services, and no Drush**. You keep managing SEO
in Drupal's Metatag UI as usual; this module just makes that output queryable.

> **Read this before installing — a hard compatibility limit.** This module targets the
> **GraphQL 3.x** plugin API. It depends on the `graphql_core` submodule and uses the
> 3.x annotation-based plugins (`@GraphQLField`, `@GraphQLType`, `@GraphQLInterface`,
> `@GraphQLScalar`) — none of which exist in **GraphQL 4.x or 5.x**. On a site running
> `drupal/graphql` 4 or 5, this module **cannot be enabled**, because `graphql_core`
> isn't available to satisfy its dependency. The broad `^9 || ^10 || ^11` core
> constraint in its info file does not change that. If you're on GraphQL 4/5, you'll
> need to write your own data producer around `metatag.manager` instead.

This guide is written for a **human** working through the setup. If you want terse,
token-cheap references for an AI coding agent — including the full field/type list and
example queries — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the GraphQL 3.x prerequisite and how to
   install and enable the module.

## Where it lives

There is no admin page — the module adds nothing to the admin menu. Its effect is
visible only in your GraphQL schema, as new fields on the `Entity`, `InternalUrl`, and
`EntityCanonicalUrl` types.

## How to use it

Because the module has no UI, "using it" means querying the fields it registers from
your GraphQL client:

- **`entityMetatags`** — the metatags for an entity (returns a list of tags; includes
  Metatag defaults, with tokens already resolved server-side).
- **`entitySchemaMetatags`** — the entity's Schema.org output as a JSON string.
- **`metatags`** — the metatags for an arbitrary internal URL or an entity's canonical
  URL (resolved through a real sub-request, so route-dependent tags like Views or
  taxonomy pages come out correct).
- On each tag: **`key`** (the tag's identifier) and **`value`** (its full attribute map
  — read `content`, or `href` for links, rather than expecting a bare string).

A minimal example, fetching a node's SEO tags on its canonical route:

```graphql
query NodeSeo($path: String!) {
  route(path: $path) {
    ... on EntityCanonicalUrl {
      entity {
        entityMetatags { key value __typename }
        entitySchemaMetatags
      }
    }
  }
}
```

To alter values, implement the standard Metatag hooks —
`hook_metatags_alter()` (entity path) and `hook_metatags_attachments_alter()` (URL
path); both are honoured. See the [`agent/`](../agent/start.md) docs for the complete
field/type reference and more query examples.
