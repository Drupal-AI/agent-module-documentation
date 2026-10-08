# GraphQL Compose Codegen — manual setup guide

**GraphQL Compose Codegen** (`graphql_compose_codegen`) generates the frontend
code your decoupled site needs — **TypeScript types, GraphQL fragments and React
component stubs** — directly from your Drupal content model, so a Next.js (or
similar) frontend stays in sync with the GraphQL schema. If you use
[GraphQL Compose](https://www.drupal.org/project/graphql_compose) to expose your
content as a GraphQL API, this module handles the tedious next step: writing the
types and queries the frontend needs to consume it, instead of you hand‑typing
boilerplate every time a field changes.

The workflow is driven mostly from **Drush**. Four commands do the work:

- **`drush gqcc:inspect`** — lists every node and paragraph bundle and the "extra"
  fields it adds beyond your shared base type, with their resolved TypeScript
  types.
- **`drush gqcc:generate`** — writes four scaffold artefacts per run: TypeScript
  type definitions, GraphQL inline fragments, a `NodeRenderer` switch‑case file,
  and one React component stub per bundle.
- **`drush gqcc:diff`** — compares the current schema against the last generation
  so you can see what changed before regenerating.
- **`drush gqcc:validate`** — verifies the scaffold files on disk are in sync with
  the live schema; it exits non‑zero, so it's safe to wire into CI or a pre‑commit
  hook.

On top of the commands, the module logs a **schema‑change notice** to
`/admin/reports/dblog` (with the exact command to run) whenever someone adds or
removes a content type, paragraph type or field through the admin UI. Paragraph
bundles are fully supported, and other modules can register their own
Drupal‑field‑type → TypeScript‑type mappers via tagged plugins. The generator also
supports `--dry-run` and `--allow-external`, writes idempotently (no churn when
nothing changed), and guards against writing to dangerous filesystem locations.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (GraphQL Compose is required).
2. [Configuration](configuration/index.md) — set your shared base type, its
   fields, and the default output directory; then run the generator.

## Where it lives in the admin menu

The settings form is at **Configuration → Development → GraphQL Compose Codegen**
(`/admin/config/development/graphql-compose-codegen`). Schema‑change notices
appear at **Reports → Recent log messages** (`/admin/reports/dblog`), and runtime
checks appear on the **Status report** (`/admin/reports/status`).
