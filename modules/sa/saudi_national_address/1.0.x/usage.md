<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Saudi National Address provides Saudi Arabia's administrative geography — regions → cities → districts — as translatable (Arabic/English) taxonomy reference data, with dependent address fields and a central address-resolution service.

---

Three vocabularies (`sna_region`, `sna_city`, `sna_district`) are installed with fields for the numeric SNA/SPL id, parent references and region/city center coordinates. `SnaImporter` seeds and updates the terms idempotently from the `yasseralsamman/saudi-national-address` dataset (via Drush or the admin form); `AddressResolver` (`saudi_national_address.address_resolver`) resolves a full hierarchy from an 11-digit district id, searches cities, and reverse-geocodes a lat/lng to region/city/district. Two HTTP routes support UI and lookups: `/sna/children/{level}/{parent}` returns dependent child terms for cascading region→city→district selects (gated by `access content`, returning only public geographic reference data), and `/sna/reverse` performs coordinate reverse lookup (gated by the dedicated `use sna reverse geocode` permission). Import/purge at `/admin/config/regional/sna` requires the restricted `administer sna data`. Queries use the DB API with `escapeLike()` (no raw SQL concatenation). An optional Select2 submodule enhances the dependent selects.

Set up by requiring the dataset package, enabling the module, running `drush sna:import`, then attaching the address fields or calling the resolver service.

---
- Install Saudi region/city/district taxonomies with Arabic + English names.
- Seed reference terms idempotently with `drush sna:import`.
- Re-import fresh data with `drush sna:import --purge`.
- Purge all SNA terms with `drush sna:purge`.
- Resolve a full address from an 11-digit district id.
- Reverse-geocode a lat/lng to region/city/district.
- Provide cascading region→city→district select fields.
- Fetch child terms for a dependent select via `/sna/children`.
- Call the reverse lookup HTTP endpoint (permissioned).
- Store SNA/SPL numeric ids on each term.
- Keep region/city center coordinates for mapping.
- Search cities by name with a LIKE query (escaped).
- Smoke-test resolution with `drush sna:resolve <districtId>`.
- Smoke-test reverse lookup with `drush sna:reverse <lat> <lng>`.
- Enhance the dependent selects with the Select2 submodule.
- Import from the admin UI at Configuration » Regional.
- Restrict data import/purge to `administer sna data`.
- Gate reverse-geocode to `use sna reverse geocode`.
- Build Saudi address forms without hardcoding geography.
- Translate term names between English and Arabic.
