<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Address Autocomplete adds address lookup to Webform's Address element, so a respondent types a few characters, picks a real address from a suggestion list, and the street, city, postal code and state fields fill themselves in.

---

Address entry is one of the highest-friction parts of any form and one of the biggest sources of bad data: transposed postcodes, abbreviated street types, missing regions. This module extends Webform's composite Address element with an "Address autocomplete" element (category *Advanced elements*) that is backed by a **provider plugin type**, `WebformAddressProvider`, so the geocoding source is swappable rather than hard-wired. Four providers ship in the box — France Base Adresse, Swiss Post (Post CH), Google Maps and Mapbox Geocoding — and you add your own by extending `WebformAddressProviderBase` and implementing `processQuery()`. The active provider is chosen site-wide at `/admin/config/webform-address-autocomplete` (`administer site configuration`); each provider then has its own sub-page for credentials such as an API key or token. At runtime the element reuses Drupal core's autocomplete: the browser calls the module's JSON route `/webform-address-autocomplete/addresses`, which invokes the configured provider server-side and returns normalized suggestions (`street_name`, `town_name`, `zip_code`, `administrative_area`, `label`, optional `location`). Choosing a suggestion writes those values into the composite's sub-fields via the attached JS behavior.

---

- Let respondents pick a real address from a lookup instead of typing five fields.
- Reduce address typos and malformed postcodes on a form.
- Speed up address entry, especially on mobile.
- Improve deliverability of collected postal addresses.
- Standardise address formats across submissions.
- Swap the lookup provider without editing any webform.
- Add autocomplete to a Webform address composite element.
- Restrict lookups to one country via the element's country field.
- Reduce form abandonment on long address forms.
- Use France Base Adresse for French postal addresses (no key needed).
- Use Google Maps Geocoding for worldwide address lookup.
- Use Mapbox Geocoding as the lookup backend.
- Use Swiss Post (Post CH) for Swiss addresses with Basic-auth credentials.
- Write a custom provider plugin for an in-house or regional address API.
- Prefill city, postcode and state from a single selection.
- Improve data quality for order fulfilment and shipping.
- Collect addresses that geocode reliably (latitude/longitude available).
- Configure the geocoding provider centrally for the whole site.
- Keep the provider API key on the server rather than in the page.
- Support international address forms with region-aware formatting.
- Reduce manual correction of submitted addresses.
- Tune sub-field order and per-field HTML autocomplete hints via custom properties.
