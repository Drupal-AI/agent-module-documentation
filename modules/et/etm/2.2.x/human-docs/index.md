# Enhanced Taxonomy Manager — manual setup guide

**Enhanced Taxonomy Manager** (project `etm`, machine name
`enhanced_taxonomy_manager`) replaces Drupal's default term‑overview page with a
fast, interactive tree view built for real‑world vocabularies — from a handful of
terms to well over 100,000. Core's overview loads every term at once as a flat
weighted list, which becomes slow and unusable at scale; ETM lazily loads children
on demand and gives you tools that make managing a large taxonomy practical.

> **Heads‑up on names:** the Drupal.org project and Composer package are `etm`, but
> the module you actually enable — and the machine name used in routes and
> permissions — is **`enhanced_taxonomy_manager`**. So you `composer require
> drupal/etm` but `drush en enhanced_taxonomy_manager`.

Around the drag‑and‑drop tree sit the operations a serious taxonomy programme
needs: live search with "go to in tree", A–Z and faceted filtering, inline rename,
term **merge** (reassigning content references), **clone**, find‑and‑replace with a
preview, orphan repair, duplicate detection, usage counts, per‑vocabulary
statistics and a health check. Changes are staged in the browser and saved as a
batch when you're ready, with **undo/redo** and named **snapshots** you can restore
in one click — which is what makes bulk edits on a production vocabulary defensible
rather than reckless. It uses modern vanilla JavaScript (no jQuery) and saves
through Drupal's Entity API, so hooks, access checks, cache invalidation and search
indexing all fire correctly.

Its access control is notably careful: administrators with **Administer taxonomy**
get full access, and everyone else can be granted per‑vocabulary permissions
(manage / export / import terms in a specific vocabulary), so you can delegate one
vocabulary to an editor without handing over the whole taxonomy. An optional
**`etm_ai`** submodule adds AI‑driven term generation, placement suggestions,
semantic duplicate detection, auto‑description, health analysis and
natural‑language search.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   (mind the machine name), and optionally the AI submodule.
2. [Configuration](configuration/index.md) — the settings form and the
   per‑vocabulary permissions that let you delegate management.

## Where it lives in the admin menu

- The enhanced tree for a vocabulary is at
  `/admin/structure/taxonomy/{vocabulary}/tree`.
- A dashboard sits at **Structure → Taxonomy → ETM dashboard**
  (`/admin/structure/taxonomy/etm-dashboard`).
- The settings form is at **Configuration → Content authoring → Enhanced Taxonomy
  Manager** (`/admin/config/content/enhanced-taxonomy-manager`).

## How to use it

Open any vocabulary's tree page and reorder terms by dragging them — changes are
held locally (a pulsing Save button reminds you of unsaved work) until you click
**Save Now**, at which point they are committed as a batch. Use the search, filters
and breadcrumb drill‑down to find terms, double‑click to rename, and use the merge,
clone, find‑and‑replace and bulk operations for larger jobs. Before a big
reorganization, save a **snapshot** so you can restore if something goes wrong.
