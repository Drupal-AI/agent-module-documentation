# Schema.org Mapper — manual setup guide

**Schema.org Mapper** (`schema_org_mapper`) turns the fields your content already
has into valid Schema.org structured data (JSON‑LD) in the page `<head>` — without
writing any code and without re‑typing information that already lives in your
fields. You tell it what kind of thing each bundle is (Product, Article, Event,
Place…) and where each property's value comes from, and at render time it reads the
real content and writes the JSON‑LD for you.

Its guiding principle is *read what is already there; never invent data*. A
property with no mapped source is simply left out, which keeps your markup aligned
with the visible page — exactly what Google's structured‑data policies require. The
module ships a curated catalog of **43 Schema.org types and 155 properties**, chosen
from Google's structured‑data documentation (required and recommended) and ordered
so the most‑used types come first. Each property can be sourced from an entity
field, a fixed value, or a token (such as `[node:title]` or `[site:name]`), and
nested objects and ordered lists (FAQ pages, breadcrumbs) are supported too.

The module is modular by design. The base module is just the engine — it depends
only on core's **Field** module and hard‑codes no entity type. To actually map
anything you enable one or more thin submodules for the entity types you use:
**Node** (`schema_org_mapper_node`), **Taxonomy** (`schema_org_mapper_taxonomy`),
**Block** (`schema_org_mapper_block`), and **Views** (`schema_org_mapper_views`).
Each one adds a "Schema.org Mapper" tab to its bundles where you do the mapping.
The base module's own settings page is a read‑only overview — the real work happens
on those per‑bundle tabs, guarded by the restricted `administer schema_org_mapper`
permission. It supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base engine plus the submodules for the entity types you use.
2. [Configuration](configuration/index.md) — the read‑only overview page and the
   per‑bundle Schema.org Mapper tab, field by field.

## Where it lives in the admin menu

The base module adds a read‑only overview at **Configuration → Search and metadata
→ Schema.org Mapper** (`/admin/config/search/schema-org-mapper`). This page is
informational only — it does not let you change mappings. The actual mapping is done
on the **Schema.org Mapper** tab that each submodule adds to its bundles (for
example on a content type, a vocabulary, a custom block type, or a View display).
