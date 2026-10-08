<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The heart of DKAN: it stores each dataset's metadata as JSON mapped onto Drupal content and exposes the metastore API for reading and writing it.

---

The heart of DKAN: it stores each dataset's metadata as JSON mapped onto Drupal content and exposes the metastore API for reading and writing it. Writes go through `MetastoreAccessManager::canUpdate`, which honours the legacy `post put delete datasets through the api` permission and otherwise defers to the entity access-control handler — so metadata mutation is a real per-entity access decision, not an open endpoint. It carries four nested submodules: the data-dictionary widget, an admin UI, and facets and search integration.

---

- Store dataset metadata as JSON.
- Read dataset metadata via the API.
- Write dataset metadata via the API.
- Map metadata onto Drupal content.
- Gate metadata writes per entity.
- Honour the legacy dataset API permission.
- Define a data dictionary for a resource.
- Administer datasets through a UI.
- Facet the dataset catalog.
- Search dataset metadata.
- Expose a DCAT-style catalog.
- Validate metadata against a schema.
- Restrict metadata writes to entitled clients.
- Keep the catalog readable publicly.
- Manage dataset schemas.
- Back the front end's catalog data.