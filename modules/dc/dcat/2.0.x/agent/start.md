<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCAT (dcat) — agent index

**Provides the DCAT (Data Catalog Vocabulary) classes — Dataset, Distribution, Agent and vCard — as Drupal content entities for publishing data-catalog metadata, with an RDF export submodule.**

- **Version:** 2.0.x (2.0.0-alpha4)
- **Core:** ^10 || ^11
- **Configure:** `dcat.admin_structure.dcat` (`/admin/structure/dcat`, perm `access dcat admin pages`)
- **Entities:** dcat_dataset, dcat_distribution, dcat_agent, dcat_vcard (+ dcat_vcard_type, dcat_field_default config entity)
- **Plugin type:** `dcat_field_provider` (core fields per class)
- **Submodule:** `dcat_export` — RDF feed at `/dcat` (perm `access dcat export feed`), settings perm `administer dcat export`
- **Key permissions:** per-entity `add/edit/delete/administer/view published/view unpublished <type> entities`; `administer dcat field defaults`
- **Security:** All entity access runs through per-type EntityAccessControlHandlers (permission-gated, published-state aware); admin routes are permission-gated; the `/dcat` export feed is gated by a dedicated permission. No anonymous mutating endpoints, no dangerous sinks observed.

See [configure/entities.md](configure/entities.md).