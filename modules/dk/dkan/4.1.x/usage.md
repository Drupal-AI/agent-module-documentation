<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DKAN is an open-data portal built on Drupal. It stores dataset metadata as JSON, imports tabular data into a queryable datastore, harvests catalogs from other portals, and serves all of it through a documented HTTP API — the software behind a government or research "open data" site.

---

An open-data portal is a specific kind of application: catalogs of datasets, each with structured metadata and one or more downloadable resources, exposed both to human browsers and to machines that expect a standards-based API. DKAN is a mature implementation of that on Drupal, and it is closer to a distribution than a module — its dependency list pulls in a metastore, an admin UI, search, a data-dictionary widget and a JSON form widget, and it is organised into submodules that each own one part of the pipeline.

The pieces fit together as a flow. **dkan_metastore** stores dataset metadata as JSON mapped onto Drupal content, and exposes the metadata API. **dkan_datastore** takes the tabular resource behind a dataset — typically a CSV — and imports it into a database table that can be queried through the datastore API, with a MySQL-import fast path in its own nested submodule. **dkan_harvest** pulls catalogs from other portals so a site can aggregate external sources. **dkan_common** provides the shared utilities and base API endpoints the others build on, including an alternate-API submodule. **dkan_js_frontend** wires a decoupled JavaScript front end to these APIs, and **dkan_sample_content** stands up demo data.

The security surface to understand is the API. DKAN's routes are gated by a set of granular, purpose-specific permissions — `datastore_api_import`, `datastore_api_drop`, `harvest_api_run`, `harvest_api_register`, and the legacy `post put delete datasets through the api` — rather than one blanket "administer" grant, and metadata writes go through a `MetastoreAccessManager` that defers to the entity access-control handler. That is the right shape for an API that different automated clients hit with different privileges: grant each client exactly the verbs it needs. Read endpoints use `access content`, so the catalog is public by default, which is usually the intent of an open-data portal but should be a conscious decision.

Because DKAN is large and infrastructural, adopt it as the basis of a data-portal site, not as a feature added to an existing content site. Its submodules are documented individually.

---

- Publish a catalog of open datasets.
- Store dataset metadata as JSON.
- Import a CSV into a queryable datastore.
- Serve datasets through a documented API.
- Harvest catalogs from other portals.
- Run a government open-data site.
- Run a research data portal.
- Query tabular data over HTTP.
- Attach a decoupled JavaScript front end.
- Grant an API client import-only access.
- Grant an API client harvest-run access.
- Keep dataset read access public.
- Restrict metadata writes to entitled clients.
- Stand up a demo with sample content.
- Aggregate external data sources.
- Expose a DCAT-style metadata API.
- Manage datasets through an admin UI.
- Define a data dictionary for a resource.
- Adopt DKAN as a portal foundation.
- Assign granular API permissions per client.
- Drop a datastore table via the API.
- Search across the dataset catalog.