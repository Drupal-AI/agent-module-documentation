# GraphQL Fragment Include — manual setup guide

**GraphQL Fragment Include** (`graphql_fragment_include`) lets you factor
repeated GraphQL fragments out into files and pull them into a query with a
custom `# include path.gql` comment. If you build a decoupled site and keep
finding yourself copy-pasting the same field selection into query after query —
the standard shape for an image, or a paragraph used by several content types —
this module lets you write that selection once and include it everywhere.

Because the GraphQL specification has no include mechanism of its own, the
module hooks into the GraphQL module's query processor: just before a query
runs, it scans the query text for `# include <file>` lines, finds each file in a
configured **fragments base directory**, and inlines its contents. Includes can
be nested, and there's protection against loading the same fragment twice, so
you can safely include a fragment inside another fragment. It pairs especially
well with the Static Suite export workflow.

Two things are worth knowing up front. First, this is a pure *text*
transformation of the query — it does not change GraphQL authorization. The
assembled query still runs through the normal schema resolvers, which enforce
their own access, so a fragment can never fetch a field a resolver would
otherwise deny. Second, includes are constrained to the configured directory:
paths are resolved and checked so that they stay within that base directory
tree, and anything out of bounds is skipped and logged.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside GraphQL.
2. [Configuration](configuration/index.md) — set the fragments base directory
   and start writing `.gql` fragment files.

## Where it lives in the admin menu

The settings form sits at **Configuration → GraphQL → Fragment Include**
(`/admin/config/graphql/fragment-include`), and it needs the **Administer site
configuration** permission.
