<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DCAT-BE — drush commands & services

## Drush
- `dcat-be:import-vocabularies` (`dcat-be-iv`) — import all controlled vocabularies.
- `dcat-be:import-vocabulary <name>` (`dcat-be-iv-one`) — import one (e.g. `eu_data_themes`).
- `dcat-be:update-vocabularies [--vocabulary=]` (`dcat-be-uv`) — add newly-published terms.
- `dcat-be:list-vocabularies` (`dcat-be-lv`).
- `dcat-be:validate-dataset <id>` (`dcat-be-vd`) — validate against DCAT-BE rules (CI-friendly).
- `dcat-be:export-dataset <id> [--pretty]` (`dcat-be-ed`) — DCAT-BE JSON-LD for one dataset.

## Vocabulary sources
`DcatBeVocabularyService` fetches from the hardcoded `VOCABULARY_SOURCES` constant (HTTPS publications.europa.eu / inspire.ec.europa.eu / belgif) with built-in fallback data. No user-supplied URLs → no SSRF; default Guzzle TLS verification.

## Export & validation
- `dcat_be.export_service` + route override of `dcat_export.export` → catalog JSON-LD feed; per-dataset export via controller/drush.
- `dcat_be.validation_service` — local field validation against DCAT-BE cardinality/mandatory rules; validate route is GET, permission + `_entity_access` gated; messages built with `t()`/escaped placeholders.

## Entities
Content entity types License, Location, Quality Measurement — reusable references with their own CRUD permission sets, list builders and access handlers.
