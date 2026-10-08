# DCAT — manual setup guide

**DCAT** (`dcat`) models the W3C **Data Catalog Vocabulary** as first-class Drupal
content entities, so a site can describe and publish datasets as structured,
machine-readable metadata. It is the base building block for an open-data catalog in
Drupal: it provides the entity types, fields, and access controls you need, and
serves as the foundation that profile extensions such as **DCAT-AP** and **DCAT-BE**
build on.

It defines four content entity types. A **Dataset** is the catalogued resource; it
references one or more **Distributions** (the actual downloadable files, services,
or URLs), an **Agent** (the publisher or responsible organisation), and a **vCard**
(a contact point), and it can be tagged against two designated taxonomy
vocabularies (`dataset_keyword` and `dataset_theme`) that are locked against
accidental deletion. Rather than hard-coding fields, the module uses a plugin-based
**field provider** system (`dcat_field_provider`), which is how DCAT-AP and DCAT-BE
add or adjust fields without changing the base entities. Field defaults can be
centrally enforced through a configuration entity.

Access is entirely permission-based and per entity type: each of Dataset,
Distribution, Agent, and vCard has its own add / edit / delete / administer /
view-published / view-unpublished permissions, enforced by a dedicated
access-control handler that respects published state. The admin area lives under
**Structure → DCAT**, behind the *Access DCAT admin pages* permission.

An optional bundled submodule, **DCAT Export** (`dcat_export`), serialises all your
DCAT entities into a single machine-readable **RDF feed** at `/dcat`, gated by its
own *Access DCAT export feed* permission — the usual way to publish catalog metadata
to external systems, open-data portals, or RDF-based integrations.

> **Note:** This 2.x version is **not** compatible with the previous 1.x module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the
   several field/entity dependencies, and enable it (plus the optional export
   submodule).
2. [Configuration](configuration/index.md) — the DCAT admin area, per-type
   settings, field defaults, permissions, and the RDF export feed.

## Where it lives in the admin menu

The DCAT admin area is at **Structure → DCAT** (`/admin/structure/dcat`), behind the
*Access DCAT admin pages* permission. Your Dataset, Distribution, Agent, and vCard
records are managed from the **Content** admin area. If you enable DCAT Export, its
RDF feed is published at `/dcat` and its settings live under the DCAT settings area.
