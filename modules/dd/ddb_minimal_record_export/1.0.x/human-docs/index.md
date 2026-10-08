# DDB Minimal Record Export — manual setup guide

**DDB Minimal Record Export** (`ddb_minimal_record_export`) maps the fields of your
Drupal content entities onto the German Digital Library's **Minimaldatensatz (MDS)**
schema and exports the result as **LIDO XML**, either for a single entity or in
bulk. It is aimed at museum and GLAM collections that need to publish object records
to the Deutsche Digitale Bibliothek (DDB) in a standards-compliant form, without
hand-building XML.

The heart of the module is a **mapping UI**: you pick a content entity type and base
bundle, then bind each MDS field to a *field path* on that entity — including
multi-hop paths through entity references (for example Object → Media → file URL). It
maintains a **versioned MDS field catalog** (bundled as data, with the ability to
import, switch between, and delete catalog versions), and you can export or import
the whole mapping as JSON to move configuration between environments. On entity
forms, mapped fields can show a small "MR" completeness badge (red for mandatory,
yellow for recommended).

Exports come in two forms. A **single-entity** export is available as a local task
(tab) on entities of the configured type/bundle, giving you a preview and download.
A **bulk** export queues a set of entities and, through Drupal's Queue API (cron or
queue workers), builds downloadable files — handy for large collections. Every
export is **validated** against the bundled digiS MDS profile XSD (LIDO 1.1 / MDS
1.0.1), and you can optionally make export fail if validation fails; for full
Schematron checking you upload the XML to the external diLIVa service.

Two permissions govern access — one for configuring mappings and one for running
exports — and version-switch/delete actions are CSRF-protected. It works with any
fieldable content entity type (WissKI's `wisski_individual` is a typical fit but not
required).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choose the entity type, load an MDS
   catalog version, map fields, and run exports.

## Where it lives in the admin menu

Its admin area is at **Configuration → Export → DDB Minimal Record**
(`/admin/config/export/ddb-minimal-record`), with a bundled help page under the same
menu. Single-entity exports appear as an **MRD Export** tab on entities of the
configured type/bundle; bulk exports run from the module's Bulk LIDO Export screen.
