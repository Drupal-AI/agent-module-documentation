# Forecast Solar — manual setup guide

**Forecast Solar** (`forecast_solar`) is developer plumbing that teaches Drupal
how to talk to the **[forecast.solar](https://forecast.solar) REST API** — a
service that estimates photovoltaic (solar panel) production and returns related
weather/location data. The module itself adds **no pages, forms, or blocks**.
Instead it registers a ready‑made API client (a Guzzle "service description") with
the [HTTP Client Manager](https://www.drupal.org/project/http_client_manager)
module, which your custom code then calls.

The registered client is named `forecast_solar_services`, points at the fixed
host `https://api.forecast.solar`, and exposes a few operations: **GetEstimation**
(a production estimate for a location and panel orientation), **CheckLocation**
(validate a latitude/longitude pair), and a plane check. A helper reshapes the
API's datetime‑keyed watt maps into tidy, iterable rows so they're easy to work
with in PHP.

A couple of practical notes. **forecast.solar's public endpoints need no API
key**, and the module stores no secret — so there is nothing to configure in a
Key entity or an environment variable. All calls go out over HTTPS to that one
fixed host, and the operations take numeric coordinates and orientation as fixed
path parameters (not a caller‑supplied URL), so there's no way to point it at an
internal host. The API is rate‑limited, though, so respect the `ratelimit`
information the responses carry and cache results in your own code when polling.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (it requires HTTP Client Manager).

There is **no settings form of its own**. The only admin surface is the HTTP
Client Manager page for this client, described in "How to use it" below.

## Where it lives in the admin menu

The module contributes no menu items of its own. You can inspect and adjust the
registered request configuration through HTTP Client Manager at
**Configuration → Web services → HTTP Client Manager → [YAML] Forecast Solar
API** (`/admin/config/services/http-client-manager/forecast_solar_services`).

## How to use it

This module is meant to be driven from code. The typical flow is:

1. Install and enable HTTP Client Manager and this module (see Installation).
2. Optionally visit the HTTP Client Manager page above to review the request
   configuration.
3. From your own module, resolve the `forecast_solar_services` client through the
   HTTP Client Manager service and call an operation — for example
   **GetEstimation** with a latitude, longitude, plane declination, azimuth, and
   installed power (kWp) to get a production estimate. The module normalises the
   datetime‑keyed results into `{ period_start, value }` rows for you.
4. Use the returned figures to build features such as a "today's expected solar
   yield" dashboard tile or an energy‑aware scheduler — and remember to respect
   the API rate limit and cache responses.

For the exact operations, parameters, and response shape, see the sibling
[`agent/api/forecast-solar.md`](../agent/api/forecast-solar.md) reference.
