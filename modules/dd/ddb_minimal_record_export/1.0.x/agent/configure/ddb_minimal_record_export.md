<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring DDB Minimal Record Export

Admin area: `/admin/config/export/ddb-minimal-record`. Mapping/version/config screens need `administer ddb minimal record`; export screens need `export ddb minimal record`.

## 1. Choose entity type & bundle
In Settings (`SettingsForm`, config `ddb_minimal_record_export.settings`) select the content entity type and base bundle to export. `RouteSubscriber` then adds per-entity routes on that type's canonical path: `{canonical}/mrd-export` and `{canonical}/mrd-export/download`.

## 2. Load an MDS catalog version
The MDS field catalog comes from bundled `data/` JSON + `mds_fields.yml`. Use the version controls to **import** (`add-version`), **switch** (`switch-version/{version}`, CSRF-protected) and **delete** (`delete-version/{version}`, CSRF-protected) catalog versions. `sync-mds-catalog-from-wiki.php` can refresh the catalog data.

## 3. Map MDS fields to Drupal fields
Open the mapping dialog (`map/{mds_id}`). For each MDS field pick a Drupal field path; options are supplied by the AJAX endpoint `field-options/{entity_type}/{bundle}` and resolved by `FieldPathResolver` (handles nested and file item properties). Export/inspect the mapping via `config-export` (JSON) and the schema via `schema-export`.

## 4. Export
- **Per entity:** visit the entity's `mrd-export` tab (preview + XSD-validated LIDO), or `mrd-export/download`. Access requires `export ddb minimal record` AND the entity matching the configured type/base bundle (`EntityExportAccess`).
- **Bulk:** `/export` (`BulkExportForm`) queues entities; a queue worker builds files into `BulkExportStorage`; download at `/export/{export_id}/download`, delete at `/export/{export_id}/delete`.

## Validation & badge
`LidoXmlBuilder` produces LIDO XML validated by `LidoXmlSchemaValidator` against the bundled LIDO 1.1 minimum-record XSD. An optional MR badge reports record completeness on entities.
