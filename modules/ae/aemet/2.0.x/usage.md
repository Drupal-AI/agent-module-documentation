<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Aemet integrates the Spanish State Meteorological Agency (AEMET) OpenData REST API to show localised weather forecasts on your Drupal site.

The module wraps AEMET's two-step API (a request returns a `datos` URL that is then fetched for the actual JSON) behind an `aemet.client` service and typed model classes. Results are cached in the default cache bin for a configurable max-age (one hour to one day, or disabled). An admin settings form stores the required AEMET API key and the cache max-age. A block (`PredictionHourlyBlock`) renders the specific hourly prediction for a locality. All HTTP calls go through Drupal's shared Guzzle `http_client` (default TLS verification) to `https://opendata.aemet.es`; the API key is sent as a query parameter.

Typical setup: obtain a free API key from AEMET OpenData, enter it at Configuration → Services → Aemet, choose a request max-age, then place the hourly-prediction block and configure it for the desired locality.

---

Short summary: shows AEMET (Spanish met agency) weather forecasts via a cached API client and a block.

It solves the problem of surfacing official Spanish weather data on a Drupal site without hand-rolling the AEMET OpenData two-hop request/caching. The `Client` service exposes `predictionsSpecific()`, which builds a `PredictionsSpecific` client that requests an endpoint, follows the returned `datos` URL, decodes the JSON (with an mb-encoding fix), wraps it in a model, and caches it.

Operationally: the API key lives in `aemet.settings` config (textarea); requests are cached keyed by an md5 of path+model; the healthcheck `ping()` hits the stations inventory endpoint. TLS is left at Guzzle defaults (verification on). The secondary fetch follows a URL supplied by AEMET's trusted API response, not by site visitors.

---

- Install the module and get a free AEMET OpenData API key.
- Enter the API key on the Aemet settings form.
- Set how long forecast requests are cached (1h / 12h / 1 day / disabled).
- Place the hourly weather-prediction block in a region.
- Configure the block for a specific Spanish locality.
- Show upcoming hourly sky-status / temperature to visitors.
- Cache AEMET responses to stay within API rate limits.
- Call `\Drupal::service('aemet.client')` from custom code to fetch predictions.
- Use `predictionsSpecific()` to retrieve a specific-prediction model.
- Health-check connectivity with the client's `ping()` method.
- Read typed model objects (e.g. `PredictionSpecificHourly`, `SkyStatus`) instead of raw JSON.
- Adjust cache lifetime to balance freshness against API load.
- Rotate the API key by updating the settings form.
- Display weather in Spanish localities on tourism or municipal sites.
- Rebuild caches by clearing the default cache bin after config changes.
- Log AEMET client activity via the `logger.channel.aemet` channel.
- Extend with new endpoint clients by subclassing `Clients\ClientBase`.
- Add new model wrappers implementing `AemetModelInterface`.
- Verify the API key works before relying on the block output.
