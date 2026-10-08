<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DDB Minimal Record Export maps Drupal content-entity fields to the German Digital Library (DDB) Minimaldatensatz (MDS) schema and exports records as LIDO XML, per-entity or in bulk.

---

The module builds a versioned MDS field catalog (from bundled `data/mds-catalog` JSON and `mds_fields.yml`, with import/switch/delete of catalog versions) and a mapping UI where you bind each MDS field to a field path on a chosen entity type/bundle (`FieldPathResolver`, AJAX field-option lookup, a mapping dialog). `LidoXmlBuilder` renders the mapped values into LIDO XML validated against the bundled LIDO 1.1 minimum-record XSD (`LidoXmlSchemaValidator`). Per-entity export routes are added dynamically by a `RouteSubscriber` on the configured entity type's canonical path (`{canonical}/mrd-export[/download]`), gated by a custom access check (`_ddb_lido_entity_export`, `EntityExportAccess`) that requires the `export ddb minimal record` permission AND that the entity matches the configured type/base bundle. Bulk export runs through a queue worker into `BulkExportStorage`, downloadable as a file. An "MR badge" can show record completeness on entities.

Admin/mapping/version/config-export/schema-export routes require the restricted `administer ddb minimal record` permission; export and bulk-export/download/delete routes require `export ddb minimal record`. Version-switch and delete routes additionally require a CSRF token. Setup: enable, choose the entity type/bundle, import the MDS catalog version, map fields, then export individual entities or run a bulk export. Suited to museum/GLAM collections publishing to the DDB.
---
Export a single content entity as LIDO XML.
- Bulk-export many entities to LIDO XML via a queue.
- Download a completed bulk export file.
- Map an MDS field to a Drupal field path.
- Choose the entity type and base bundle to export.
- Preview the generated LIDO XML for an entity.
- Validate output against the bundled LIDO 1.1 XSD.
- Import a new MDS catalog version.
- Switch the active MDS catalog version.
- Delete an MDS catalog version.
- Export the current mapping as JSON.
- Export the MDS schema as JSON.
- Show a Minimal Record completeness badge on entities.
- Resolve nested/file field paths for mapping.
- Set global export defaults.
- Restrict mapping configuration to trusted admins.
- Allow an exporter role to run LIDO exports.
- Publish museum object records to the DDB.
- Report missing required MDS fields per entity.
- Add a per-entity "MRD export" local task/tab.
- Delete an old bulk export and its file.
- Use AJAX field-option lookup while mapping fields.
