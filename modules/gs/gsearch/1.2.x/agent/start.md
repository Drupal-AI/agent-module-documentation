<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GSearch (Dataforsyningen) (gsearch) — agent index

Danish address field for Drupal, backed by **Dataforsyningen's GSearch v2 REST API**. Adds an
`address_gsearch` field type (with a matching Select2 widget and a formatter) so editors pick a
real Danish address by autocomplete instead of typing free-hand. Selecting a suggestion stores a
normalized address plus `postnummer`, `postnummernavn`, country code (`DK`) and WGS84 lat/long.
An optional per-field free-text mode accepts non-Danish/informal addresses. Positioned as a
replacement for the DAWA-based `address_dawa`.

- Depends on core `field` and contrib `select2:select2`; composer also requires
  `thecodingmachine/safe ^2` and `ext-json`.
- Core: `^10.5 || ^11`. Configure at `/admin/config/gsearch/config`
  (route `gsearch.settings`, permission `administer site configuration`).
- No module-specific permissions, no drush commands, no plugin types of its own.

Solution docs:
- **Set the API token / endpoint** → [configure/settings.md](configure/settings.md)
- **Add & use the address field (type, widget, formatter, free-text)** → [fields/address.md](fields/address.md)
- **Look up addresses / build field values from code** → [api/service.md](api/service.md)

Key facts:
- Config object `gsearch.settings`: keys `api_url` (default
  `https://api.dataforsyningen.dk/rest/gsearch/v2.0/`) and `token`. Schema in
  `config/schema/gsearch.schema.yml`.
- Service id `gsearch.address` → `Drupal\gsearch\Services\Gsearch`
  (`getAddresses()`, `getAddress()`, `getAddressById()`, `getFieldValue()`,
  `getFieldValueById()`, `validateToken()`; static `encodeSelect2Value()` / `decodeSelect2Value()`).
- Field plugin ids (all `address_gsearch`): FieldType `AddressGsearchItem`, FieldWidget
  `AddressGsearchWidget`, FieldFormatter `AddressGsearchFormatter`. Field settings key
  `allow_freetext`; widget settings `size` / `placeholder` / `freetext_coords`.
- Widget autocomplete endpoints (called by Select2): `gsearch.autocomplete` → `/gsearch/address`
  and `gsearch.autocomplete.select2` → `/gsearch/address/select2`
  (`GsearchAutocomplete::getResults` / `getResultsSelect2`).
- Value object `Drupal\gsearch\GsearchAddress`; field interface
  `Drupal\gsearch\AddressGsearchItemInterface`.
- Theme hooks `gsearch_address` / `gsearch_addresses`; templates in `templates/`; CSS library
  `gsearch/base`.
- Update hook `gsearch_update_10001` adds a `country_code` column to existing `address_gsearch`
  field tables.
