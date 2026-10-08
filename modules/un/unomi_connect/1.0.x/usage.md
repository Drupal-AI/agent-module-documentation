<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unomi Connect connects Drupal to an Apache Unomi customer-data-platform instance and provides admin screens to browse Unomi profiles, segments, rules, conditions and actions.

---

Unomi Connect provides the core `unomi_connect` service (a Guzzle client using the configured base URI/port and HTTP basic auth username/password from `unomi_connect.settings`) plus a `makeRequest()` helper for calling the Unomi `/cxs/*` REST API. The parent module offers a settings form (`/admin/config/services/unomi-connect/settings`, permission `administer site configuration`) and a raw 'Make request' form. Five submodules add feature UIs: `unomi_profiles` (list/view visitor profiles and their events), `unomi_segments` (list/add/delete segments), `unomi_rules`, `unomi_conditions` and `unomi_actions`. Guzzle is used with default TLS verification (not disabled). Note the connection username/password are stored in plaintext config and shown in a plaintext form field; and several submodule routes use inconsistent permissions (`access content`, or the non-existent `administer site`) - see findings.

---

- Connect Drupal to an Apache Unomi instance.
- Store the Unomi base URI, port, username and password.
- Call the Unomi /cxs REST API from Drupal.
- Browse visitor profiles from the admin UI.
- View the events recorded against a profile.
- List and inspect Unomi segments.
- Add a new segment via a form.
- Delete a segment with confirmation.
- List Unomi rules, conditions and actions.
- Send a raw JSON request to a Unomi endpoint.
- Inject a Unomi tracking script into pages.
- Authenticate to Unomi with HTTP basic auth.
- Decode Unomi list responses into arrays.
- Extend behavior through the five submodules.
- Integrate a customer-data platform for personalization.
