# Entity Reference Translation Sync — manual setup guide

**Entity Reference Translation Sync** (`ert_sync`) keeps the values of a node's
**entity‑reference fields** aligned across all of its translations. On a
multilingual site, some reference fields — related content, media, taxonomy — should
be identical in every language rather than maintained separately per translation.
This module does that automatically.

When you save a node, the module looks at the node's entity‑reference fields and
propagates the source values into the node's other translations, then saves the
affected translations using Drupal's Batch API. By default it only fills in *empty*
target fields (or reconciles when the number of values differs), so it tops up
translations rather than clobbering deliberate per‑language differences.

It is intentionally simple: there is **no configuration UI, no routes and no
permissions**. The whole behaviour lives in the node‑update hook and runs on the
normal server‑side save path, so who can trigger it is governed entirely by core's
node access — anyone who can save a node. Because the sync behaviour is automatic
and hook‑driven, it is worth exercising on a staging site before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — behaviour is automatic on
node save, described in "How to use it" below.

## How to use it

1. Make sure your site is set up for multilingual content — core's **Content
   Translation** (`content_translation`) module enabled, and the entity‑reference
   fields you care about marked translatable on the relevant node types.
2. Enable Entity Reference Translation Sync (see [Installation](installation/index.md)).
3. Edit and save a node that has translations. The module copies the source
   translation's reference values into the other translations (filling empty
   targets by default) and saves them via a batch process, showing a per‑translation
   message and a completion summary.

To stop synchronizing, simply uninstall the module — values already written to
translations are left in place.

> **Note:** Test on staging first. The behaviour runs inside the node‑update flow,
> so confirm it does what you expect for your specific field setup before enabling
> it on a live multilingual site.
