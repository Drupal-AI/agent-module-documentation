# DKAN — manual setup guide

**DKAN** (`dkan`) is an open‑data portal built on Drupal — the software behind a
government or research "open data" website. It stores dataset metadata as JSON,
imports tabular files (typically CSVs) into a queryable **datastore**, harvests
catalogs from other portals, and serves all of it through a documented HTTP API
for both human browsers and machine clients. It is inspired by CKAN and is a
mature, standards‑based implementation of the open‑data portal pattern on Drupal.

It's important to set expectations up front: DKAN is closer to a **distribution
than a single module**. Its dependency list pulls in a metadata store, an admin
UI, search, a data‑dictionary widget and the JSON Form Widget, and installing it
brings a sizeable dependency tree with it. Adopt DKAN as the *foundation* of a
data‑portal site, not as a feature bolted onto an existing content site.

The moving parts fit together as a pipeline, each owned by a submodule:

- **dkan_metastore** stores dataset metadata as JSON mapped onto Drupal content
  and exposes the metadata API.
- **dkan_datastore** takes the tabular resource behind a dataset — usually a CSV —
  and imports it into a database table you can query through the datastore API. A
  nested submodule provides a faster MySQL‑import path.
- **dkan_harvest** pulls catalogs from other portals, like an RSS reader for
  datasets, so a site can aggregate external sources.
- **dkan_common** provides the shared utilities and base API endpoints the others
  build on.
- **dkan_js_frontend** wires a decoupled JavaScript front end to the APIs.
- **dkan_sample_content** stands up demo datasets so you can see the portal
  working immediately.

The security surface to understand is the **API and its permissions**. DKAN's
write routes are gated by granular, purpose‑specific permissions — such as
`datastore_api_import`, `datastore_api_drop`, `harvest_api_run` and
`harvest_api_register` — rather than one blanket "administer" grant, so you can
give each automated client exactly the verbs it needs. Read endpoints use core's
`access content` permission, which anonymous users hold by default, so **the
catalog is public out of the box** — usually the intent of an open‑data portal,
but make it a conscious decision.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install DKAN with Composer, enable the
   submodules you need (including the datastore), and load sample content.
2. [Configuration](configuration/index.md) — the dataset/datastore workflow,
   datastore settings, and the API permission model, section by section.

## Where it lives in the admin menu

DKAN doesn't have one single "DKAN settings" screen; its administration is spread
across several places under **Configuration** and **Content**. The datastore
settings sit at **`/admin/dkan/datastore`**, datasets are managed as content, and
the API permissions live on the standard **People → Permissions** page. See the
[Configuration](configuration/index.md) guide for the full tour.
