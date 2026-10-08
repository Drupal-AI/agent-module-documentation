# Dynamic Facet Cascade — manual setup guide

**Dynamic Facet Cascade** (`dynamic_facet_cascade`) places a configurable **block of
cascading AJAX drop‑downs** in front of a Search API search‑results page. Visitors
make sequential selections — for example *Make → Model → Version* — and each
drop‑down only reveals options relevant to the choice above it. On submit, the block
builds a Facets‑compatible URL and redirects the visitor to the results view,
pre‑filtered by everything they chose.

It solves a familiar problem with Search API + Facets: powerful filtering, but a
wall of checkboxes or drop‑downs with hundreds of options and no native way to scope
the choices progressively. This module turns that into a guided funnel — *first pick
a brand, then only see models for that brand* — so users are led toward relevant
results instead of scanning everything at once.

The module is **heavily tied to Views and Search API**. The redirect target must be
a **Views page display whose base table is a Search API index**, and the facets the
block pre‑fills must use that display as their facet source. Because of this, setup
has a specific order: you create the facets first, then build a "preset" (which
becomes the block) that chains those facets into an ordered cascade. It depends on
core **Views**, plus **Search API** and **Facets**; its administration is gated by
the core **Administer site configuration** permission, and it supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Search API / Facets dependencies.
2. [Configuration](configuration/index.md) — create the facets, build a preset, and
   define the cascade levels, then place the block.

## Where it lives in the admin menu

Preset management lives at **Configuration → Search and Metadata → Dynamic Facet
Cascade** (`/admin/config/search/dynamic-facet-cascade`). The facets it depends on
are managed separately under **Configuration → Search and Metadata → Facets**
(`/admin/config/search/facets`), and each saved preset becomes a **block** you place
under **Structure → Block layout**.
