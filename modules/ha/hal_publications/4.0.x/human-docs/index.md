# HAL Publications — manual setup guide

**HAL Publications** (`hal_publications`) pulls publication lists from
**HAL** (*Hyper Articles en Ligne*), the French open-research archive, and renders
them on your Drupal site. It's the tool a research lab or institution uses to show
"here are our papers" — kept in sync with HAL rather than maintained by hand — with
formatted citations, filtering, sorting, and pagination.

This is the **4.x** line, a modern rewrite focused on accuracy and staying aligned
with the HAL API. In 4.x, authors are represented by a dedicated **Hal Author**
content entity that is decoupled from Drupal user accounts (unlike the legacy 3.x
"AMU_HAL" workflow, which tied HAL metadata to individual users). It ships a shared,
hardcoded set of HAL API fields used consistently across **APA 7, MLA 9, Vancouver,
and Harvard** citation styles, block-level sorting with predefined options
(newest/oldest, author A–Z, title A–Z), built-in pagination, standard filters
(author, year, free text), and a 10,000-row cap on HAL API results.

Configuration in 4.x is deliberately streamlined: you set the HAL **portals** and
**collections** to query, an **SSL toggle**, and an **API timeout** — and that's
essentially it. One security note on that SSL toggle: it exists for awkward network
environments, but **leave SSL/TLS verification enabled** in production. Turning it
off means the site will accept an unverified certificate when talking to HAL, which
undermines the integrity of the connection. Publication data itself comes from HAL,
so treat it as external content.

> **Upgrading from 3.x?** The rewrite changes the data model. Back up your
> configuration first, remove deprecated 3.x config keys and re-export, create Hal
> Author entities (or migrate your author data) before enabling the new blocks, then
> rebuild blocks to pick one of the new sort options and clear caches. The legacy
> per-user "publications" profile tab is **not** part of 4.x — keep it only by
> staying on 3.x.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.
2. [Configuration](configuration/index.md) — portals, collections, the SSL toggle,
   the API timeout, and how publication blocks are placed and sorted.

## Where it lives in the admin menu

Once enabled, the module provides a **settings** form (portals, collections, SSL
toggle, API timeout) in the **Configuration** area, a **Hal Author** entity type
you manage under the content/structure admin, and **blocks** you place through
**Structure → Block layout** — see [Configuration](configuration/index.md).
