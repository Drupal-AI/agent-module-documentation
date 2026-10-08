# Entity Import — manual setup guide

**Entity Import** (`entity_import`) gives site administrators a point‑and‑click
interface for importing entities into Drupal from external sources. Getting outside
data into a site as content — a product feed, a member list, a content export —
comes up on almost every project, and Entity Import turns that into a configurable
workflow instead of hand‑written migration code.

Under the hood it is built on Drupal core's **Migrate** API, so an importer you
build in the UI behaves like a proper migration: you point at a source, map source
columns to entity fields, and apply data processing and transformations (migration
lookups, entity lookups, string replacement, and so on) — the same things you'd
write by hand in a migration YAML file, but through a form. Importers can also
declare **dependencies** on one another, so a set of related imports is managed
together in one interface rather than across many screens. At present the source is
**CSV files**, with a plugin architecture designed to grow to other formats; the
`entity_import_plus` submodule adds further source types.

One thing to keep in mind: importing **creates and updates entities**, so it is a
write capability. An import can overwrite existing content, so restrict who may
configure and run imports to trusted roles, review your field mappings and source
data before running against production, and take a backup first — treat it like any
bulk‑write tool.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it (it needs core Migrate), and optionally add the plus submodule.
2. [Configuration](configuration/index.md) — build an importer: choose a source,
   map fields, add data processing, and run the import safely.

## Where it lives in the admin menu

Entity Import adds its importer‑management screens to the site's administration
area, reachable by users with the module's administer permission. Because the
project does not publish a single fixed configure route, the workflow — where you
create importers, map fields, and run imports — is described step by step in
[Configuration](configuration/index.md).
