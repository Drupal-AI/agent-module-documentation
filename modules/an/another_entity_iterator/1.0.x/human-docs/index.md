# Another Entity Iterator — manual setup guide

**Another Entity Iterator** (`another_entity_iterator`) is a developer utility, not
a site feature you configure in the UI. It provides a helper for **iterating over
entities in manageable batches** — loading and processing large numbers of entities
(nodes, users, or any entity type) without exhausting PHP's memory. It is the kind
of tool you reach for when writing a bulk update, generating a report, or running a
migration over thousands of records.

There is nothing to configure and nothing visible on the site: you enable the
module and then call its iterator from your own code. Because it loads entities on
the calling code's behalf, entity loading **bypasses per‑entity access checks
unless you add them** — so if your iteration feeds anything user‑facing, apply the
appropriate access checks yourself. The module has no content type or access role
of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — it provides no admin pages, permissions, or blocks. It is a code‑level
helper.

## How to use it

1. Enable the module (see [Installation](installation/index.md)) — usually as a
   dependency of a custom module or as a tool for a one‑off script.
2. Use the iterator from your own code to walk over an entity set in batches.
3. Apply your own access checks if the results are shown to users.
