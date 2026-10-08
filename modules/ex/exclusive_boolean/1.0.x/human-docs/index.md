# Exclusive Boolean — manual setup guide

**Exclusive Boolean** (`exclusive_boolean`) solves a small but common problem:
making sure only **one** node of a content type carries a particular flag at a
time. Think of a "Featured" checkbox on articles, a single "current" homepage
hero, or one active announcement. By default Drupal happily lets you tick that
box on any number of nodes, so keeping it to a single item means custom code or
manual cleanup. This module handles it for you.

Once you enable the exclusive behaviour on a boolean field, editors keep working
exactly as before — they simply tick the box on the node they want. When they
save, the module automatically **unchecks the same field on every other node of
that content type**. The most recently saved node becomes the only one where the
flag is set, with no extra steps for the editor.

The logic is scoped to the specific content type and field where you switch it on,
runs automatically on node save, and is lightweight with no external
dependencies. It's a content‑editing/data‑integrity feature — it manages the
field's value and has **no access‑control role**. It depends only on core's
**Field** module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no separate settings page** — you switch on the exclusive behaviour
right in the field's settings, described below.

## Where it lives in the admin menu

Exclusive Boolean adds no admin page of its own. You enable it per field under
**Structure → Content types → *(your type)* → Manage fields → *(your boolean
field)***.

## How to use it

1. Make sure the content type has a **boolean** field (a checkbox‑style field) —
   for example a "Featured" field. Add one under **Manage fields** if needed.
2. Edit that field's settings. Exclusive Boolean adds an **Exclusive** option to
   boolean fields; turn it on and save.
3. That's it. From now on, whenever an editor saves a node with that box ticked,
   the module unchecks the same field on all other nodes of the same content type,
   so only the just‑saved node keeps the flag.

Typical uses include a homepage featured item, a single active announcement or
alert, one "current" event, or one primary reference node.
