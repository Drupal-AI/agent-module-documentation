# Last Visited Pages — manual setup guide

**Last Visited Pages** (`last_visited_pages`) keeps a per‑user "recently viewed"
history and shows it in a block. As a user moves around the site, an event
subscriber records each route they visit, and a block plugin lists the **title,
URL, and time** of each recent visit. It keeps up to the last 20 pages per user,
and you can configure how many links the block displays.

A recently‑viewed list is a genuinely useful navigation aid on content‑heavy
sites — an intranet where people return to the same handful of documents, a
catalog where a shopper retraces their steps, or a documentation site. It is
small and self‑contained: an event subscriber, a block, a settings form, and
cache invalidation so the block stays current.

The thing to be deliberate about is that this is **tracking**, and tracking is a
privacy surface. The module records, per user, which pages they looked at and
when — the kind of browsing‑history data that carries expectations and, in some
jurisdictions, obligations. That is fine and expected for authenticated users on
a site where the feature is visible and the benefit is theirs. Before switching it
on for a broad audience, give thought to **whether anonymous users should be
tracked at all** (they are far more numerous, their history is less useful to
them, and it is more of a storage and privacy question), and to **where the
history is stored and how long it is kept**. Note the module is **not covered by
Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set how many links the history block
   keeps, and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Last Visited Pages**
(route `last_visited_pages.settings`,
`/admin/config/last-visited-pages-settings`). The history itself is shown through
a **Last Visited Pages** block placed from **Structure → Block layout**
(`/admin/structure/block`).
