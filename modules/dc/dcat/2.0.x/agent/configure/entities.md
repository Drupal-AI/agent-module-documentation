<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCAT — entities, permissions & export

## Entity types
- `dcat_dataset` — the catalogued dataset; references Distributions, an Agent and a vCard, plus `dataset_keyword`/`dataset_theme` taxonomies.
- `dcat_distribution` — a concrete access form of a dataset (file/service/URL).
- `dcat_agent` — publisher / responsible organisation.
- `dcat_vcard` (bundled by `dcat_vcard_type`) — contact point.
- `dcat_field_default` (config entity) — enforced default/locked field values.

## Admin routes
- `/admin/structure/dcat` — overview (`access dcat admin pages`).
- `/admin/structure/dcat/settings` — module settings.
- `/admin/structure/dcat/types` — per-entity-type settings.
- `/admin/structure/dcat/field-defaults` — field-default rules (`administer dcat field defaults`).
- Content lists under `/admin/content` (DCAT Datasets).

## Permissions (per entity type: dataset, distribution, agent, vcard)
`add …`, `edit …`, `delete …`, `administer … entities` (restricted), `access … overview`,
`view published … entities`, `view unpublished … entities`. Access handler grants full access on `administer <type> entities`, else checks the published-state-appropriate view permission.

## Extending fields
Implement a `DcatFieldProvider` plugin (attribute `\Drupal\dcat\Attribute\DcatFieldProvider`, base `DcatFieldProviderBase`) to add base fields to a DCAT class; core fields ship as `DatasetCoreFields`, `DistributionCoreFields`, `AgentCoreFields`, `VcardCoreFields`.

## Export (dcat_export submodule)
`DcatExportService` builds an EasyRdf graph of all DCAT entities and serialises it. Route `dcat_export.export` at `/dcat` (perm `access dcat export feed`); dispatches `AddResourceEvent`/`SerializeGraphEvent` so other modules can enrich the graph. Settings at `/admin/structure/dcat/settings/dcat_export` (perm `administer dcat export`).