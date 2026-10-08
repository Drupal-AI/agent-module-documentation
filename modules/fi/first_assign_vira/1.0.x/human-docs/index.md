# Entity Auto Term — manual setup guide

**Entity Auto Term** (project `first_assign_vira`, machine name `first_assign_vira`,
internal module name `eat`) automatically creates a taxonomy term that mirrors an
entity's title whenever a matching entity is created. Map a content type (or other
entity bundle) to one or more vocabularies, and from then on every new node of that
type gets a term named after its title, created in the vocabularies you chose. Edit
the entity later and the linked term's name is kept in sync. It depends on core's
Views module.

This is useful when you want a "mirror" taxonomy of your content — for example a
tag vocabulary that always has a term matching each article title — without editors
tagging by hand. The module records the entity→term link in its own database table,
reuses an existing term when one with the same title already exists, and exposes the
linked term to Views as a default contextual-filter argument so you can drive
related-content listings from it.

For content that already existed before you set up the mappings, a **bulk backfill**
batch creates the missing terms in one pass.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — map entity/bundle combinations to
   vocabularies, then optionally run the backfill batch.

## Where it lives in the admin menu

Entity Auto Term lives under **Configuration → System**:

- **Settings (mappings):** `/admin/config/system/eat`
- **Bulk backfill batch:** `/admin/config/system/eat/batch`

Note the internal machine name is `eat`, so its routes and config use that prefix.
