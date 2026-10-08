<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AddEvent API surface

Service `addevent.api.factory` (`Drupal\addevent\AddEventApiFactory`, args `@http_client`, `@config.factory`).

- `AddEventApiFactory::create()` reads `addevent.settings:token`; throws if the token is unset.
- Builds an `AddEventCalendarApi` (`src/Api/`) whose `BaseApi::request()` issues Guzzle requests with `Authorization: Bearer <token>` to the AddEvent endpoints (default TLS verification — no `verify => false`).
- Use from custom code: `\Drupal::service('addevent.api.factory')` then call the calendar API methods.
