# Facets Custom Label — manual setup guide

**Facets Custom Label** (`facets_custom_label`) lets you rename the individual
items shown in a facet. On a faceted search page, a facet item's text usually
comes straight from your data — a content-type machine name like `article`, a
term name, a status value like `1`. This module maps those to friendly labels you
supply, so visitors see *Awesome news* instead of `article`, or *Published*
instead of `1`, without changing the underlying content or query.

It works as a **Facets processor** — a small plugin you turn on for a specific
facet. You give it a list of mappings, one per line, and at render time it
rewrites the visible label of any matching facet item. You can match either an
item's **raw value** (its machine name or entity ID) or its **display value**
(the title or term name that's currently shown). Crucially, only the visible
label changes: the raw values, the search query, and the result counts stay
exactly as they were.

Because the labels live in the facet's configuration, they export cleanly with
your config for deployment, and you can translate them per language by enabling
core's Configuration Translation module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn the processor on for a facet
   and write your label mappings.

## Where it lives in the admin menu

Facets Custom Label has **no settings page of its own**. You configure it inside
an individual facet's edit form, under the **Processors** section, at
**Configuration → Search and metadata → Facets**
(`/admin/config/search/facets`).
