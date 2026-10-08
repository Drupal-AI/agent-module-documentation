# GBIF — manual setup guide

**GBIF** (`gbif2`) integrates the GBIF (Global Biodiversity Information Facility)
REST API into Drupal. It exposes GBIF **occurrence records** as read‑only
**External Entities**, adds a species‑name **autocomplete**, and provides **Views**
support so you can build listings of GBIF occurrences directly — without storing
them locally on your site. Combined with Views Bulk Operations you can also process
occurrences, for example to import them locally with Migrate.

The module builds on the **External Entities** module: a submodule provides a
storage client that talks to GBIF, so an "external entity type" you create behaves
like normal Drupal entities in Views while the data lives at GBIF. Because GBIF is
a public API, occurrence records fetched through the module are read‑only — saving
and deleting are no‑ops.

The bundled species autocomplete endpoint is publicly accessible and simply
forwards your search term to GBIF's public name‑suggestion API. That's expected
behaviour, but be aware it is an unauthenticated proxy to a third‑party service.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its External
   Entities dependency with Composer, then enable the submodules you need.

There is no global settings form for this module — you set it up by creating an
external entity type and building Views, described below.

## How to use it

1. Enable `gbif2`, plus `gbif2_entity` (the storage client) and `gbif2_views`
   (Views integration).
2. Create an **external entity type** that uses the storage client named **gbif**,
   and map its fields — for example GBIF's `key` to the entity ID,
   `occurrenceID` to the UUID, and `scientificName` to the title. Refer to the
   GBIF Occurrence API for the full list of available fields.
3. Add a new **View** of type **GBIF occurrences**, then choose the fields and
   filters you want. Note that **sorting is not supported** by the GBIF API.
