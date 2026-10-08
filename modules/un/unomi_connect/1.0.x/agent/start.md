<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unomi Connect - agent index

Client for the **Apache Unomi** customer-data platform (CDP). Version **1.0.3**, core `^8 || ^9 || ^10`. Submodules: unomi_actions, unomi_conditions, unomi_profiles, unomi_rules, unomi_segments.

- Service `unomi_connect` (`UnomiConnect`): Guzzle client from `unomi_connect.settings` (base_uri, port, username, password) + `makeRequest($method,$uri,$json)` -> Unomi `/cxs/*`. TLS default-on.
- Parent routes: settings form + `make_request` form (both `administer site configuration`); `unomi_connect.admin` (`access administration pages`).
- SECURITY: creds stored/displayed in plaintext config; `unomi_segments.form_segments` (add segment) and `unomi_actions.list` are gated by `access content` = effectively anonymous. Several routes use bogus `administer site` (fail-closed). See findings.