# Entity Field Lookup — manual setup guide

**Entity Field Lookup** (`entity_field_lookup`) is a **Migrate API process
plugin** for developers building migrations. It finds an existing entity by
running an EntityQuery against a **field you name in the migration**, rather than
by an ID or a migration map — so you can resolve a reference by whatever value your
source actually gives you.

The problem it solves shows up constantly in real imports. Core's
`migration_lookup` finds an entity by the ID *another migration* created, which is
great when you control both sides — and useless otherwise. And "otherwise" is
common: you're importing against terms a site builder made by hand, a spreadsheet
identifies people by email address, a feed names categories by their label, or a
second import has to attach to entities the first one made but whose IDs nobody
recorded. In each case the source names the target by *something other than its
ID*, and this plugin looks it up by that value: query a field, get the entity.

There is **no UI and no configuration screen** — you use it entirely inside a
migration's YAML process pipeline. It supports Drupal 10.1 and 11 and has no module
dependencies beyond core's Migrate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this is a developer plugin used in migration
definitions. See "How to use it" below.

## How to use it

Reference the plugin as a process step in your migration YAML, telling it the
target entity type, the field to query, and the source value to match. It returns
the matching entity's ID for you to use as a reference.

Three things decide whether the lookups stay reliable — and, importantly, getting
them wrong produces *quietly incorrect data* rather than loud errors:

1. **The queried field must be unique in practice.** Two people with the same
   surname, two terms with the same name in different vocabularies, two products
   sharing a code — a lookup returning the first match silently attaches content
   to the wrong entity, which is worse than failing outright.
2. **A miss needs a defined outcome.** Decide whether a no-match should skip the
   row, create a stub, or fail the migration. Each is defensible; the wrong one
   leaves either silent gaps or a vocabulary full of stubs nobody meant to create.
3. **A query per row is a query per row.** On a large migration this is often the
   slowest part — measure it, and add an index on the field being queried.

The [`agent/`](../agent/start.md) docs carry the compact reference.
