# Entity Count — manual setup guide

**Entity Count** (`entity_count`) adds a simple admin **report of how many entities
exist on your site**, broken down by type and, where a type has more than one
bundle, by bundle. It's a census: at a glance you can see how many nodes, users,
taxonomy terms, and other entities are stored in the database — handy for keeping
tabs on content growth and for reasoning about performance.

The report lives under **Reports**, and access to it is gated by an **"Access entity
count"** permission. There's nothing to configure — enable the module, grant the
permission, and the report is ready.

The report only ever shows **aggregate numbers** — never titles, IDs, or individual
rows — and both of its routes require the "Access entity count" permission. It is an
administrative report, so grant that permission to trusted administrators and site
builders who need the counts.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and grant the report permission.

There is **no configuration page** for this module — it works as soon as it's
enabled and the permission is granted.

## Where it lives in the admin menu

Once enabled, you'll find the **Entity count** link under **Administration →
Reports** (`/admin/reports`). Click it to see the list of entity types, their
counts, and a per‑bundle breakdown for types that have multiple bundles.
