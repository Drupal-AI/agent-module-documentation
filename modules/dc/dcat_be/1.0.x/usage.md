<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DCAT-BE implements the Belgian Federal DCAT-AP (DCAT-BE / Belgif INSPIRE) profile: it adds BE-specific fields, three content entities, controlled-vocabulary import, DCAT-BE JSON-LD export and dataset validation.
---
The module extends `dcat` + `dcat_ap` to the Belgian federal profile. It contributes BE-specific fields and constraints through DcatFieldProvider plugins, defines three content entity types (License, Location, Quality Measurement), imports EU/Belgian controlled vocabularies as multilingual taxonomy terms (fetched from official publications.europa.eu / inspire.ec.europa.eu / belgif sources with built-in fallback data), exports datasets and the whole catalog as DCAT-BE JSON-LD, and validates datasets against DCAT-BE cardinality/mandatory rules. A route subscriber overrides `dcat_export.export` for the catalog feed and redirects the vcard add page to an organization-only form.

Permissions are granular: `administer dcat be` (settings + vocabulary import), `export`/`validate dcat be datasets`, `administer dcat_be entities`, plus full CRUD sets for each of the three entity types. The vocabulary import fetches only from a hardcoded `VOCABULARY_SOURCES` list of HTTPS EU/gov URLs (no user input → no SSRF) with default TLS verification, and the validation route is read-only, permission-gated and `_entity_access`-gated. Set up by enabling the module, running the vocabulary import (UI or drush), then creating datasets and exporting/validating.
---
- Make a catalog compliant with the Belgian federal DCAT-BE profile
- Import all EU/Belgian controlled vocabularies as taxonomy terms
- Import a single vocabulary (e.g. eu_data_themes)
- Update vocabularies to add newly-published terms
- Create/edit/delete License entities
- Create/edit/delete Location entities
- Create/edit/delete Quality Measurement entities
- Export a single dataset as DCAT-BE JSON-LD (drush or UI)
- Serve the whole catalog as a DCAT-BE JSON-LD feed
- Validate a dataset against DCAT-BE rules in the UI
- Validate a dataset via drush in CI pipelines
- Enforce Dutch/French bilingual metadata (validation warnings)
- Auto-set dcat_issued on first save and dcat_modified on each save
- Simplify the DCAT export settings form to BE-relevant fields
- Force vcard contact points to the Organization bundle only
- Translate catalog title/description via config_translation
- Manage licenses/locations/quality-measurements as reusable referenced entities
- Configure catalog cache max-age for the feed
- Add a JSON-LD export link on dataset full view
- List available vocabularies via drush
