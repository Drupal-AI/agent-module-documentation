# Fix Anonymous Nodes — manual setup guide

**Fix Anonymous Nodes** (`fix_anonymous_nodes`) is a small administrator tool for
cleaning up content authorship. When you delete a user account in Drupal, the
nodes that person created are often left "orphaned" — they end up owned by the
Anonymous user (uid 0) or point at a user id that no longer exists, so they show
up as authored by *Anonymous*. This module gives you one admin form that finds
all those orphaned nodes and reassigns them, in bulk, to a real user you choose
(for example your `admin` account or a dedicated editorial account).

It's the kind of thing you reach for after a staff departure, a GDPR erasure, a
bulk user purge, or a content migration — any time you're left with published
pages whose author link is broken or reads "Anonymous". Under the hood it finds
the distinct authors present on your nodes, works out which ones no longer match a
real account (plus uid 0), then loads each affected node and re‑saves it with the
new owner.

Because it **re‑writes node authorship in the database**, treat it as a data
change, not a display tweak. Take a database backup before you run it. It also
processes every matching node in a single request with no batching, and re‑saving
each node triggers the normal save hooks, revision handling, and search
re‑indexing — so on a large site it can be slow and should be run in a
maintenance window.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permission.
2. [Configuration](configuration/index.md) — run the reassignment form, field by
   field, with the safety notes.

## Where it lives in the admin menu

The tool lives under **Content → Fix Anonymous Nodes**
(`/admin/content/fix-anonymous-nodes`). Access is gated by a dedicated **Fix
anonymous nodes** permission, which is deliberately restricted — grant it only to
trusted administrators, since it can mass‑reassign authorship across your whole
site.
