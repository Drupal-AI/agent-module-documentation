# Facets Taxonomy Multilevel — manual setup guide

**Facets Taxonomy Multilevel** (`facets_taxonomy_multilevel`) adds two
[Facets](https://www.drupal.org/project/facets) processors — **Term Depth** and
**Term Dependent** — that make a hierarchical taxonomy behave sensibly as a facet.
A deep vocabulary makes a poor flat facet: a "Category" with four levels and
hundreds of terms produces a list where the useful distinctions disappear. These
processors show only the level a visitor has reached, giving the drill‑down
experience people expect from a catalogue.

**Term Depth** limits a facet to terms at a chosen hierarchy depth, so a facet can
show only top‑level categories (for example *Fruits* and *Vegetables*) until one is
chosen. **Term Dependent** makes a facet's contents depend on what has been selected
in another facet, so a second facet narrows to the children of the first — pick
*Fruits* and the second facet shows *Apple*, *Mango*, *Banana*; pick *Vegetables*
and it shows *Potato*, *Onion*, *Garlic*. Select both parents and all their children
appear.

Both are ordinary Facets processor plugins, enabled per facet from the Facets UI.
They change how an existing facet behaves without altering the search index or the
facet's source, so turning them on and off is free and reversible. The processors
apply only to taxonomy fields, and **Term Dependent** depends on **Term Depth**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Facets.

There is **no module‑wide settings page** — the processors are enabled and tuned per
facet, described in "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page of its own. You configure the processors from
**Configuration → Search and metadata → Facets** (`/admin/config/search/facets`), on
the individual facets built from a taxonomy field.

## How to use it

Consider a multilevel vocabulary: *Fruits* (Apple, Mango, Banana) and *Vegetables*
(Potato, Onion, Garlic), on a search page with two facets.

1. **Parent facet (L1 terms).** Edit the facet, open its **processors**, and enable
   **Show terms of defined depth** (Term Depth). Set the depth so only top‑level
   terms — *Fruits* and *Vegetables* — appear.
2. **Child facet (L2 terms).** On a second facet over the same field, enable **both**
   processors: **Term Depth** for the child level, and **Show terms based on Dependee
   Facet** (Term Dependent) pointing at the parent facet. Now the child facet shows
   only the children of whichever parent is selected.
3. Save the facets. On the search page, visitors pick a category first and then drill
   into its subcategories, keeping each facet block short and relevant.

Use it for any deep vocabulary — a product taxonomy, a subject hierarchy in a library
catalogue, region‑then‑city chains — where a flat facet would overwhelm visitors.
