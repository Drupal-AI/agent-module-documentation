<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GBIF (gbif2) — agent index

**Integrates the GBIF biodiversity REST API: occurrence records as read-only External Entities, a species autocomplete, and Views plugins.**

- **Version:** 2.0.x
- **Core:** ^9 || ^10 || ^11
- **Depends on:** external_entities (>=3.0.0-beta1); PHP client `resttelae/gbif`.
- **Submodules:** `gbif2_entity` (StorageClient `gbif`), `gbif2_views` (query/field/filter plugins, VBO subscriber).
- **Services:** `gbif.helper`, `gbif.occurrence`, `gbif.species`.
- **Route:** `gbif2.species_autocomplete` → `GET gbif2/species-autocomplete` (`_format: json`).
- **Security:** the autocomplete route is `_access: 'TRUE'` (fully anonymous). It forwards only the `q` query param to GBIF's fixed public `nameSuggest` endpoint and HTML-escapes output — **not** SSRF (host is not user-controlled) and no XSS, but it is an unauthenticated, unthrottled proxy to a third-party API (minor abuse/amplification surface). Storage client is read-only (`save()`/`delete()` are no-ops).

See [api/external-entity.md](api/external-entity.md).