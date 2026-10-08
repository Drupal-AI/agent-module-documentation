<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Connects Drupal to the GBIF biodiversity REST API to browse and display species occurrence records.
---
GBIF (Global Biodiversity Information Facility) publishes a large REST API of geolocated species occurrence records. This module wires that API into Drupal via the `resttelae/gbif` PHP client, exposing three services: `gbif.helper` (enumerations for basis-of-record and continent), `gbif.occurrence`, and `gbif.species`. The base module also defines a species-name autocomplete route.

The `gbif2_entity` submodule provides an External Entities storage client (`@StorageClient("gbif")`, `\Drupal\gbif2_entity\Plugin\ExternalEntities\StorageClient\Gbif`) mapping GBIF occurrences to a read-only `gbif_occurrence` external entity type — `load()`, `querySource()`, and `countQuerySource()` proxy to the GBIF `Occurrences` client, while `save()`/`delete()` are intentionally no-ops (read-only). The `gbif2_views` submodule adds Views query, field, and filter plugins (continent, country, taxon key, basis-of-record, numeric) plus a VBO event subscriber so editors can build occurrence listings. Setup: require `external_entities`, enable the submodules you need, and configure a `gbif_occurrence` external entity type. Note: the species-autocomplete route is unauthenticated — see the security posture below.
---
- Browse GBIF occurrence records as Drupal external entities.
- Add a species-name autocomplete to a custom form (`gbif2/species-autocomplete`).
- Build a Views listing of occurrences with GBIF-specific filters.
- Filter occurrences by continent, country, or taxon key.
- Filter by basis of record (fossil, human observation, living specimen, ...).
- Look up an occurrence by GBIF key via `load()`.
- Page through occurrence search results (limit/offset).
- Count matching occurrence records for a query.
- Map GBIF `key`/`occurrenceID`/`scientificName` to entity id/uuid/title.
- Expose biodiversity data on a public site without local storage.
- Use the `gbif.helper` service for basis-of-record enumerations.
- Use continent enumeration labels in a custom UI.
- Suggest scientific names as an editor types.
- Integrate GBIF data into a taxonomy or research portal.
- Apply Views Bulk Operations to occurrence result sets.
- Add GBIF numeric-range filters (e.g. year, elevation) in Views.
- Keep occurrence data live/read-only (no import into the DB).
- Debug GBIF filter transliteration via the storage client's debug logging.