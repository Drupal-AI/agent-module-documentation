# GraphQL Compose: Fragments — manual setup guide

**GraphQL Compose: Fragments** (`graphql_compose_fragments`) auto‑generates
**GraphQL fragments** for the schema that
[GraphQL Compose](https://www.drupal.org/project/graphql_compose) produces, so
front‑end clients can select fields without hand‑writing them.

The problem it solves is one every decoupled build runs into. GraphQL Compose
builds a large schema automatically from your site's entity types, fields and view
modes. The hard part isn't querying that schema — it's keeping queries **in step**
with it: a field added in Drupal is invisible to a client until someone edits a
query, and a field removed breaks one silently. Fragments are GraphQL's answer — a
named, reusable field selection per type — and generating them from the *live*
schema means the client's selections track the site instead of drifting from it.

The workflow is deliberately simple: **configure**, **generate**, **commit the
fragments alongside your front‑end code**, and **regenerate when the content model
changes**. Because the fragments are files, a content‑model change shows up as a
pull‑request diff rather than a runtime surprise, and downstream codegen tools can
turn the fragments into typed clients.

These fragments are intended as a **guide, not a finished solution** — use them to
get up and running quickly, then refine as your application needs dictate. You can
also optionally **expose fragments on the schema itself**, so they appear in the
`info` query:

```graphql
query {
  info {
    fragments {
      type
      name
      class
      content
    }
  }
}
```

This is a thin extension: it has **no permissions or routes of its own** beyond its
settings form and inherits GraphQL Compose's access model. It requires PHP 8.1 and,
of course, a working GraphQL Compose installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (GraphQL Compose and PHP 8.1 required).
2. [Configuration](configuration/index.md) — the fragment‑generation settings.

## Where it lives in the admin menu

The settings form is the route `graphql_compose.fragments`, alongside the other
GraphQL Compose settings. See [Configuration](configuration/index.md).
