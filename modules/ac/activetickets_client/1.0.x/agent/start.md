<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveTickets Client (activetickets_client) — agent index

A developer-facing **SOAP client service** for the ACTIVE Network **ActiveTickets** ticketing/events web
service. It wraps a `\SoapClient` built from admin-configured WSDL URLs and exposes typed methods that map
to ActiveTickets SOAP operations (programs/events, genres, visitors, passes, routes). Package
`ActiveTickets`. Core `^10 || ^11 || ^12`. License GPL-2.0-or-later. Version 1.0.1. **No** entities,
permissions, blocks, controllers, Drush commands, or hooks — just one service + one settings form.
Requires the **ext-soap** PHP extension. No module dependencies; no composer.json.

- **The two client services, how to inject them, and the full method surface** →
  [api/client.md](api/client.md)
- **Settings form, config object `activetickets_client.settings`, and schema keys** →
  [config/settings.md](config/settings.md)

## What it actually provides (from source)

- Class `Drupal\activetickets_client\Client\ActiveTicketsClient` implementing
  `ActiveTicketsClientInterface` (`src/Client/`). Constructor takes `logger.factory`, `config.factory`, a
  cache backend, and a `bool $memberClient` flag; `initSoapClient()` news up `\SoapClient($wsdl)` with a
  stream context that adds the `x-api-key: <token>` header.
- Two services in `activetickets_client.services.yml`:
  - `activetickets_client.client` — public WSDL (`wsdl_url`).
  - `activetickets_client.member_client` — 4th arg `'true'` → member WSDL (`wsdl_member_url`).
- One config object `activetickets_client.settings` (schema in `config/schema/`): `wsdl_url`,
  `wsdl_member_url`, `client_name`, `langcode`, `ticket_url`, `token`.
- One route `activetickets_client.settings` at `/admin/config/system/activetickets_client`
  (`Form\ActiveTicketsSettingsForm`, `_permission: administer site configuration`), plus a config menu link.
- `.module` file is empty; `.install` absent; no `config/install/` defaults (all config keys start unset).

## Method surface (high level)

- Reads (`get()` → `parseXmlResult()` → array): program listings (`getProgramList`, `…Big`, `…Light`,
  `…WithCapacities`, `…WithCapacitiesAndSold`, `…WithCustomKey[IFFR]`), `getProgramDetail`,
  `getProgramStatus`, `getGenreList`, `getSubGenreList`, `getLocationList`, `getCharacteristicsList`,
  `getRouteList`, `getPassList`, visitor reads (`getVisitor`, `getVisitorByEmail`,
  `getVisitorByCredentials`, `getVisitorOrderHistory`, `getVisitorsLight`, …).
- Writes (`set()`): `setVisitorNew`, `setVisitorUpdate`, `setVisitorDelete`,
  `setVisitorNewsLetterByEmail`, `add/removeInterestToVisitor`, `save/removeCharacteristic…`,
  `getVisitorWebserviceLoginKey`, `createVisitorIfNotExistsAndGetLoginKey`.
- Caching: `getCachedProgramList()` stores/reads `activetickets_client:programlist:<genreId>` in
  `cache.default` (no explicit expiry/tags).
- Stubs returning `[]`: `eventAndShowsImport()`, `savePassToVisitor()`, `removePassFromVisitor()`.
- Constant `DATEFORMAT = 'Y-m-d\TH:i:s'`; all `\DateTime` params are formatted with it (birth dates use
  `Y-m-d`). `getAllVisitorIdsWhoOrderedLastnMinutes()` clamps `minutes` to 1440.
