<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Solcast wires the Solcast solar resource / forecasting REST API into Drupal as a declarative HTTP Client Manager service.

---

Solcast (https://api.solcast.com.au) sells solar irradiance and PV-power estimates and forecasts. Rather than hand-rolling a client, this module ships a `solcast.http_services_api.yml` service description and a set of Guzzle-services YAML resource definitions under `src/api/` (rooftop-site forecasts, estimated actuals, and a data dictionary), so calling code obtains a ready client from the `http_client_manager` factory and invokes named commands. The base URI is fixed to `https://api.solcast.com.au` (TLS) in the service config.

Authentication is not embedded in the core module: it is added by the optional `solcast_key` submodule, whose `AddAuthorizationSubscriber` injects an `Authorization` header from a Key entity (`key.key.solcast_api_key`), keeping the API secret out of code. A second submodule, `solcast_eca`, exposes an ECA action (`SetIntervalStart`) plus an interval-operation helper so no-code ECA models can drive Solcast calls. There are no routes, blocks, or permissions in the base module — it is a developer integration surface. Typical setup: require the module, enable `solcast_key`, store the Solcast API key in a Key, then call the client from your own service or an ECA model.

---
- Require the module via Composer alongside `http_client_manager`.
- Fetch a configured Solcast client from the `http_client_manager` factory service.
- Call the rooftop-site `forecasts` resource for forward-looking PV/irradiance data.
- Call the rooftop-site `estimated_actuals` resource for recent past output.
- Read the `data/data_dictionary` resource to discover available fields.
- Enable the `solcast_key` submodule to add API-key authentication.
- Store the Solcast API key in a Key entity instead of settings/code.
- Let `AddAuthorizationSubscriber` attach the Authorization header automatically.
- Enable the `solcast_eca` submodule to drive Solcast from ECA models.
- Use the `SetIntervalStart` ECA action to set a forecast interval start.
- Point integrations at the fixed `https://api.solcast.com.au` base URI over TLS.
- Add new endpoints by dropping YAML resource files under `src/api/resources`.
- Log API activity through the dedicated `logger.channel.solcast` channel.
- Build dashboards that display forecast solar generation for a site.
- Feed PV forecasts into scheduling or automation logic.
- Compare estimated actuals against metered production.
- Keep the API client declarative (YAML) rather than in PHP.
- Reuse the same client across multiple modules on the site.
