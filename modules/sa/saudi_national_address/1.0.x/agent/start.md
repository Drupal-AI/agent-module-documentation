<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Saudi National Address (saudi_national_address) — agent index
**Saudi region/city/district reference taxonomies (ar/en), dependent address fields and an address-resolution service.**

- **Version:** 1.0.x  **Core:** ^10 || ^11  **Depends:** taxonomy, options, field, language, content_translation
- **Vocabularies:** `sna_region`, `sna_city`, `sna_district` (fields: sna id, parent refs, center lat/lng, SPL code).
- **Routes:** `/sna/children/{level}/{parent}` (perm `access content`, public reference data); `/sna/reverse` GET (perm `use sna reverse geocode`); settings `/admin/config/regional/sna` (perm `administer sna data`, restricted).
- **Services/Drush:** `AddressResolver` (`saudi_national_address.address_resolver`), `SnaImporter`; `sna:import[/--purge]`, `sna:purge`, `sna:resolve`, `sna:reverse`.
- **Security:** DB API with `escapeLike()`, no SQL concatenation. Cascade route exposes only public geographic data under `access content`; reverse-geocode and admin import are permission-gated. Sound.

See [drush/import.md](drush/import.md)
