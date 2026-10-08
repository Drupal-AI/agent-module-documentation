# Field Autoincrement — manual setup guide

**Field Autoincrement** (`field_autoincrement`) adds a new **field type** that
automatically generates a sequential, ever‑incrementing number for each new
entity. It is ideal wherever you need unique, human‑readable identifiers —
**order numbers, invoice IDs, ticket numbers, custom reference codes**.

Each time an entity (a node, user, or custom entity) is created, the field gets the
next number in the sequence. You can dress that number up with a configurable
**prefix** and **suffix**, so a raw `1001` can render as `INV-1001-2023`, and you
can set the **starting number** for the sequence (for example, begin at `1000`).
The numbers are generated **atomically**, so even under concurrent saves two
entities never receive the same value.

It is a fields feature built on core's Field API — it generates and stores a number
and has no bearing on content access. You can add multiple autoincrement fields to
the same entity type.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings page** — you add and configure the field per bundle,
as described in "How to use it" below.

## How to use it

1. Go to the bundle you want to number, e.g. **Structure → Content types → (your
   type) → Manage fields**, and click **Add field**.
2. Choose the **Auto Increment** field type and give it a label.
3. In the field's settings, configure:
   - the **prefix** (e.g. `INV-`),
   - the **suffix** (e.g. `-2023`),
   - the **start value** (e.g. `1000`).
4. **Save**. From now on, each new entity of that bundle receives the next number
   in the sequence — for example `INV-1001-2023`, `INV-1002-2023`, and so on.

You can add more than one autoincrement field to the same entity type if you need
independent sequences.
