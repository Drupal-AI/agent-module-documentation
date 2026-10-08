<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web Service Data (wsdata) models an external web service as Drupal configuration: you define a server (an endpoint plus a transport connector) and a call (which server, which response decoder and request encoder, plus per-call options), then read the decoded response from PHP, a block, or an entity field — no bespoke API-client module needed.

---

The recurring shape of a web-service integration is always the same — call a service, decode the response, pick out a value, render it — and the usual result is a one-off module per service. WSData splits those parts into swappable plugins and stores the wiring as config. A **WSServer** entity holds the endpoint and a **WSConnector** plugin (Simple HTTP, HTTP-with-language, GraphQL, SOAP, or a local file). A **WSCall** entity points at a server and pairs it with a **WSDecoder** (JSON, XML, string, or a list decoder from `wsdata_extras`) and a **WSEncoder** (JSON or string) for the request body, plus connector options such as the path, HTTP method, headers and a cache TTL. Calls run through the `wsdata` service (`WSDataService::call()`), which fills `[name]` replacements and Drupal tokens into the URL, performs the request, decodes the body, selects a nested value by a colon-delimited key, and caches the result in a dedicated `wsdata` cache bin (GET responses honour the endpoint's `Cache-Control: max-age` or a per-call expiry). Submodules provide the consumption points: `wsdata_block` renders a call as a block, and `wsdata_field` binds a call to a custom-storage entity field so the value is fetched at entity-load time. Everything is admin-configured under *Structure → Web Service Server / Web Service Call* and *Configuration → Web services → WSData settings* (all behind `administer site configuration`), and it exports and deploys with the site like any other config.

---

- Show data from an external REST API inside a block.
- Populate an entity field from a web service at load time.
- Configure a REST integration without writing an API client.
- Call a SOAP service from Drupal via the SOAP connector.
- Query a GraphQL endpoint and render selected fields.
- Read a local JSON/XML file as a data source.
- Decode a JSON response and pick a nested value by key path.
- Decode an XML response into a nested array.
- Substitute `[name]` replacements and Drupal tokens into a request URL.
- Swap the current content language into an endpoint URL.
- Cache external responses in a dedicated cache bin with a TTL.
- Reuse one server across several calls.
- Add a new transport by writing a connector plugin.
- Add a custom response format by writing a decoder plugin.
- Deploy an integration entirely as exported configuration.
- Show live inventory, exchange rates, or a status feed on a page.
- Test a configured call from the admin UI before wiring it up.
- Expose a web-service value as a Views field.
- Point an exported integration at a per-environment endpoint via State.
- Prototype an integration quickly without a bespoke module.
