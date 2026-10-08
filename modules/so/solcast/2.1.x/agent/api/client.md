<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Solcast API client

Solcast defines an HTTP Client Manager service; you do not write a Guzzle client by hand.

## Service definition
`solcast.http_services_api.yml`:
- `api_path: src/api/solcast_services.yml`
- `config.base_uri: https://api.solcast.com.au`

Resource command YAML lives under `src/api/resources/`:
- `rooftop_sites/forecasts.yml` — forward PV / irradiance forecast.
- `rooftop_sites/estimated_actuals.yml` — recent modelled output.
- `data/data_dictionary.yml` — field dictionary.

## Authentication (solcast_key submodule)
Enable `solcast_key`. It ships `key.key.solcast_api_key` and an event subscriber
`Drupal\solcast_key\EventSubscriber\AddAuthorizationSubscriber` that adds the
`Authorization` header from the Key. Store the real key in the Key entity — never in code.

## ECA (solcast_eca submodule)
Provides the `SetIntervalStart` action plugin and an interval helper so ECA models can
schedule/parameterise Solcast requests without custom PHP.

## Calling
Obtain the named client from the `http_client_manager` factory and call the command
matching the resource id. All traffic is HTTPS to the fixed base URI.
