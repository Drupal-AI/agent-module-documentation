<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Address provides country/subdivision data and postal-code validation over JSON:API.

---

JSON:API Address exposes the Address module's reference data — countries and their subdivisions (states/provinces) — through JSON:API, plus postal-code validation, so a decoupled front end can populate address forms and validate input against the same data Drupal uses.

Access is gated by dedicated permissions (`jsonapi_address access address data`, `jsonapi_address access postal code validation`). Depends on core `jsonapi`, `jsonapi_resources`, and `address`; supports Drupal 10 and 11.

---

- Expose country/subdivision data via JSON:API.
- Provide postal-code validation.
- Serve Address reference data.
- Support decoupled address forms.
- Validate input against Drupal's data.
- Gate with `jsonapi_address access address data`.
- Gate validation with a dedicated permission.
- Depend on core `jsonapi` and `address`.
- Depend on `jsonapi_resources`.
- Support Drupal 10 and 11.
- Populate address dropdowns.
- Serve subdivisions.
- Support decoupled front ends
- Provide address APIs.
- Validate postal codes.
- Expose reference data.
- Integrate Address with JSON:API.
- Support address input
