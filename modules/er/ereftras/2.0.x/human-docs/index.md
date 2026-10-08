# Entity Reference Field Translation Synchronize — manual setup guide

**Entity Reference Field Translation Synchronize** (`ereftras`) fixes a specific,
annoying multilingual problem: when you turn on **"Users may translate this field"**
for an entity-reference field that already has translated content, the existing
translations end up with **empty reference values**. This module backfills them —
copying the reference value from each entity's original (source) translation into
its other translations, so the translated content points at the same referenced
targets as the source again.

It works in two places. It adds a **synchronize option to the field settings form**
so you can trigger the fix at the moment you enable translation on a field, and it
provides a **bulk admin form** where you pick an entity type, a bundle and one or
more translatable reference fields and run the fix across all matching content as a
Batch API process. By default it only fills *empty* translated values; an option
lets you overwrite all values instead.

It requires the core **Content Translation** module and supports Drupal 9, 10 and
11. It's a one-off repair/maintenance tool (in the *Devel* package) rather than
something that runs continuously.

> **Restrict access.** The bulk synchronize form drives a batch that saves content
> across the site, and the module's route for it is **not gated by a dedicated
> permission** — so treat the URL as sensitive, run the operation only as a trusted
> administrator, and don't expose the path on a public site. Take a database backup
> before a large run, especially if you use the "overwrite" option.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Content Translation.
2. [Configuration](configuration/index.md) — the per-field synchronize option and
   the bulk admin form, step by step.

## Where it lives in the admin menu

The bulk form is at **Configuration → Development → Entity Reference Field
Translation Synchronize** (`/admin/config/development/ereftras`).
