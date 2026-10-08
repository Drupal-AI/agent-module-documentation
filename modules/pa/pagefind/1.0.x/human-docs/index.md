# Pagefind Search — manual setup guide

**Pagefind Search** (`pagefind`) brings fast, **client‑side** search to Drupal. Unlike
Solr or Elasticsearch, there is no search server to provision, tune, secure or pay for:
the module builds a highly compressed **static index**, and searching then happens
entirely in the visitor's browser (via WebAssembly), fetching only the few kilobytes of
index a given query actually needs. A thousand people searching at once generate zero
database queries on your site.

Under the hood it's a Drupal bridge to the Rust‑based **Pagefind** engine, with extra
Drupal features layered on top: **faceted listing pages** (filterable, sortable,
paginated archives and directories) built through a Search Displays UI, an **expert field
formatter** for marking fields as filters / metadata / sortable and weighting them for
relevance, **synonyms** with an admin UI that re‑stage affected content via cron,
**featured results** ("best bets") for promoting content on chosen keywords, and
**multisite collections** that merge several Pagefind‑powered sites into one search
experience. A **Setup Wizard** gets you from install to a working search page without
reading the manual.

Because the index is just static files, you can build it anywhere — in CI, on staging, or
on the site itself — and production only has to *serve* files. The module is engineered
for sites up to roughly **50,000 indexed documents**; above that a status‑report warning
appears and a server‑side backend is likely the better tool. The real limit is usually
build‑time memory (roughly 200 MB of RAM per 1,000 pages of substantial text), since the
binary indexes the whole staging directory in a single pass.

Note this is a **beta** release (1.0.0‑beta2).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, check the private
   file system and outbound‑HTTPS requirements, and enable the module.
2. [Configuration](configuration/index.md) — run the Setup Wizard, build the index, and
   set up search displays, synonyms and featured results.

## Where it lives in the admin menu

Pagefind is administered from its own **dashboard**, reached from the admin menu once the
module is enabled; the guided **Setup Wizard** is launched from there. Index
administration is governed by the **Administer pagefind index** permission. (The module
does not declare a single core "configure" route, so use the dashboard and Setup Wizard
as your starting point — see [Configuration](configuration/index.md).)

## How to use it

The quickest path is: install and enable the module, open the dashboard, run the **Setup
Wizard** to create a working search page, then build the index. From there you can add
faceted **search displays**, mark fields with the expert formatter, define **synonyms**,
and promote **featured results**. All of this is covered in
[Configuration](configuration/index.md).
