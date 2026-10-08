<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GSearch provides Danish address fields backed by Dataforsyningen's official GSearch API, so an address is chosen from the national register by autocomplete rather than typed free-hand.

---

Danish addresses are authoritative data: the government publishes them through Dataforsyningen, and matching against that register is how you get consistent, geocodable, postcode-correct addresses instead of a hundred spellings of the same street. This module wires that register into Drupal as an `address_gsearch` field type with a Select2-based widget and a formatter. `src/Services/Gsearch.php` (service `gsearch.address`) is the API client, targeting `https://api.dataforsyningen.dk/rest/gsearch/v2.0/` by default with both the base URL and an API token configurable at `/admin/config/gsearch/config`. When an editor picks a suggestion the field stores the normalized display address plus `postnummer`, `postnummernavn`, country code and WGS84 latitude/longitude; a per-field "allow free-text" option lets non-Danish or informal addresses be stored by hand. `GsearchAddress` models a result row, `AddressGsearchItemInterface` exposes typed getters, and two Twig templates render single and multiple addresses. Requirements are core `^10.5 || ^11`, Select2 `^2` and `thecodingmachine/safe ^2`. It is positioned as a replacement for the DAWA-based `address_dawa`.

---

- Let editors pick a Danish address from the official register.
- Guarantee postcode and street name are consistent.
- Autocomplete addresses as the user types.
- Store structured address data rather than free text.
- Geocode content from an authoritative source.
- Populate an address field on a contact form.
- Avoid typos in customer addresses.
- Support a Danish public-sector site's data quality rules.
- Render addresses with a Twig template.
- Use Select2 for a searchable address picker.
- Keep addresses aligned with national data.
- Configure a different API base URL for local stubs or testing.
- Support multiple addresses on one entity.
- Improve delivery accuracy for a shop.
- Match addresses for deduplication.
- Provide address data (lat/long) to a map integration.
- Reduce manual address correction.
- Enable free-text mode for non-Danish addresses.
- Build field values programmatically in a custom migration.
- Meet a requirement to use Dataforsyningen data.
