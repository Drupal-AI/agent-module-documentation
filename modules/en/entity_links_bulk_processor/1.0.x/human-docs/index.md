# Entity Links Bulk Processor — manual setup guide

**Entity Links Bulk Processor** (`entity_links_bulk_processor`) is a
content-maintenance tool for cleaning up links and markup across large amounts of
existing content in bulk. Its headline job is **entity link conversion**: it scans
body and other text fields and rewrites internal links — for example
`/node/123` paths or path-alias URLs — into UUID-based **entity links**. Because
the resulting links reference an entity's UUID rather than a path, they keep
working even when node IDs or aliases change later, and they use the same
`data-entity-type` / `data-entity-uuid` markup that Drupal core's Entity Links
filter and the Linkit module understand.

It is aimed squarely at **migrations and legacy cleanup** — the classic case is a
Drupal 7 → 10/11 migration that left thousands of nodes full of old paths and
media tokens. Beyond link conversion it can validate and normalize `mailto:`,
`tel:`, `sms:`, and `fax:` links, map or strip CSS classes across HTML elements
(useful for theme upgrades such as Bootstrap 3 → 5), convert legacy media
markup, and process content language-by-language on multilingual sites. An
optional **Entity Links Autosave** submodule (`entity_links_autosave`) extends the
same processing to run as content is saved, so newly pasted-in legacy markup gets
cleaned up on the fly rather than only in one-time batches.

Because it **rewrites stored content in bulk**, treat it as a privileged
operation: run it as a trusted operator, take a database backup first, and test on
a copy before touching production. Access to its tools is gated by the module's own
permissions. Note that at the time of writing it is an **alpha** release and is
**not** covered by Drupal's security advisory policy — factor that into your
decision to use it on a production site. It depends on Drupal core's **Filter**
and **Path Alias** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   pick up the optional Autosave submodule.

## Where it lives in the admin menu

The module exposes admin tooling for scanning and converting content, reachable
by users who hold its permissions. It works alongside — not in conflict with —
core's Entity Links and the Linkit module: this module does the one-time bulk
cleanup of historical content, while core/Linkit handle new entity links going
forward.

## How to use it

The typical workflow is a controlled, one-time run:

1. **Back up your database** and, ideally, work on a copy of the site first.
2. Grant the module's permissions only to the trusted operator who will run the
   cleanup.
3. Use the module's tools to scan content, review what will change (for CSS class
   mapping it can discover existing classes and their usage counts so you decide
   the mappings), and then run the bulk conversion.
4. Spot-check converted content, and confirm links resolve correctly.
5. Optionally enable the **Entity Links Autosave** submodule so ongoing edits keep
   content clean without another batch run.
