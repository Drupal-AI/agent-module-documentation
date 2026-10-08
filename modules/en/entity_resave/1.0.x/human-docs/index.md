# Entity batch resave — manual setup guide

**Entity batch resave** (`entity_resave`) lets an administrator push every node or
media item of a chosen bundle back through its normal save path, in batches. It
provides two admin forms — one for nodes, one for media — where you pick a bundle
and start a Batch API run that loads and re‑saves each matching entity.

Re‑saving is a common maintenance task. It recomputes computed fields,
repopulates the defaults of a newly added field on existing content, and re‑fires
the presave/insert hooks that other modules hang behaviour on — search indexing,
Pathauto alias generation, cache invalidation — all without writing a one‑off
script. Batching keeps large sites from timing out, and the process is logged so
you can see how many entities were processed and any errors. The node form adds an
**Update last changed date** option: leave it unchecked and the batch restores each
entity's original `changed` timestamp, so re‑saving does not bump modification
times.

The module has no dependencies of its own and no settings form — you use it
straight from its two batch forms.

> **Security warning — lock these routes down.** As shipped, all three routes
> (the node resave form, the media resave form, and the completion redirect) are
> gated **only** by the core *access content* permission, which Drupal grants to
> the anonymous role by default. There is no per‑entity access check and no
> dedicated administrative permission. In principle, anyone who can view content
> could load these forms and trigger a site‑wide re‑save of every node or media
> item in a bundle — a data‑mutation and resource‑exhaustion vector. Before using
> this on a production or public site, restrict the routes (for example require an
> administrative permission, or make them admin routes) and consider running large
> jobs on a staging copy first.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

This module has no settings form. You drive it from the two batch forms described
below.

## Where it lives in the admin menu

The forms live under **Configuration → Development**:

- **Entity Resave: NODE** — `/admin/entity_resave/resave-node`
- **Entity Resave: MEDIA** — `/admin/entity_resave/resave-media`

## How to use it

1. Open `/admin/entity_resave/resave-node`, select a content type, and submit
   **Resave nodes** to start the batch. Leave **Update last changed date**
   unchecked to preserve the original modification times, or tick it to let the
   re‑save bump them.
2. Open `/admin/entity_resave/resave-media`, select a media bundle, and submit to
   re‑save all media of that type.
3. Watch the standard Batch API progress bar; you land on a completion page when
   the run finishes.

Because the batch loads and saves every matching entity, plan for the load on
large bundles and prefer testing on a staging copy first.
