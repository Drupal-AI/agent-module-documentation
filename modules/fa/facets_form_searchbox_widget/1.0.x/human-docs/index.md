# Facets Form Searchbox Widget — manual setup guide

**Facets Form Searchbox Widget** (`facets_form_searchbox_widget`) adds a searchbox
widget to the [Facets](https://www.drupal.org/project/facets) module so that a long
list of facet values becomes searchable: the visitor types into a box and the facet
values filter down as they type (find‑as‑you‑type within a single facet). This
makes facets with many values far more usable than a long, scroll‑heavy checkbox
list.

Specifically, it extends the Facets **searchbox widget** so that it can be used
inside a **Facets Form** — the form‑based presentation of facets — where the
stock searchbox widget would not otherwise apply. If you present your facets as a
submitted form rather than instant‑apply links, this is the module that brings the
type‑to‑filter box along.

It is a display‑layer widget: it shapes how a facet is presented and never changes
what a visitor is allowed to see — results still follow the search index's access
rules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Facets dependency.

There is **no central configuration page** for this module — you choose the
searchbox widget on each facet, described in "How to use it" below.

## Where it lives in the admin menu

Facets Form Searchbox Widget adds no admin page of its own. You select it from the
**Facets** admin UI (**Configuration → Search and metadata → Facets**,
`/admin/config/search/facets`) when editing an individual facet that is presented
through a Facets Form.

## How to use it

1. Set up your facet and present it through a **Facets Form** as usual.
2. Edit the facet and choose the **searchbox** widget provided by this module.
3. Save, then load the page with the facet form and confirm the searchbox filters
   the facet's values as you type.
