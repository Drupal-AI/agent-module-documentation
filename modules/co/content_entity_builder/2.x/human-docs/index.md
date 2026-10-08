# Content Entity Builder — manual setup guide

**Content Entity Builder** (`content_entity_builder`) lets you create custom
content entity types through the admin UI — no PHP, no hand‑written entity classes
or annotations. You define a new entity type, add base fields to it, configure its
entity keys and paths, and the module syncs that configuration to a real database
table for you. It fills the same niche as ECK: a way to build bespoke content
entities (an "Author", a "Product", a "Location") without turning them into nodes.

When you create an entity type you choose a **Mode** that decides how much
machinery it gets:

- **Basic** — the simplest form: one entity, one table, keeping your database
  clean.
- **Basic Plus** — Basic plus bundle support.
- **Advanced** — bundles, translatability, an owner, a changed timestamp, and
  published status.
- **Full** — a node‑like content type: everything in Advanced plus revisions.

A standout feature is **export**: once you've designed an entity type in the UI,
you can export it to module code and download it, which saves a great deal of time
compared with writing a custom content‑entity module by hand.

This is a **developer / site‑builder tool used at build time**, not a runtime
feature. Because it generates code and defines entity types — which carry access
implications — treat it as a powerful admin capability: restrict it to trusted
developers, and after you create an entity type, review its generated access
handler and configure permissions for it just as you would for any custom entity.
A practical tip from the maintainers: **clear the cache** if you hit odd behavior
after making changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the step‑by‑step workflow for
   building, configuring, and exporting a content entity type.

## Where it lives in the admin menu

Content Entity Builder adds its screens under **Structure → Content types**
(`/admin/structure/content-types`) — this is where you add and manage the custom
content entity types it creates, add base fields, and reach the **Export** tab.
Permissions for the entity types you build are managed at **People → Permissions**
(`/admin/people/permissions`).
