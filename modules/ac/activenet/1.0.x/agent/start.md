<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveNet (activenet) — agent index

A thin, read-only PHP client for the **ACTIVE Network (ActiveNet)** activity/registration REST API,
exposed to Drupal as the service **`activenet.client`**. Package **YMCA Website Services**. Core
`^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.6 (dir `1.0.x`). No Composer deps, no
Drupal module dependencies, no submodules, no config schema.

- **Config form, the client service, all API methods, and how to consume it** →
  [api/client.md](api/client.md)

## What it actually is

- **One service:** `activenet.client` (`activenet.services.yml`) — a `Drupal\activenet\ActivenetClient`
  produced by the factory `activenet.client.factory` (`ActivenetClientFactory::get()`, arg
  `@config.factory`). `ActivenetClient` **extends `GuzzleHttp\Client`** and implements the empty
  marker `ActivenetClientInterface`.
- **One config object:** `activenet.settings` with two keys — `base_uri` and `api_key` (install
  defaults empty, `config/install/activenet.settings.yml`). No `config/schema/` ships.
- **One route:** `activenet.settings` → `Form\SettingsForm` at
  `/admin/openy/integrations/activenet/settings`, requirement `_permission: 'administer activenet'`.
  Menu link `activenet.admin` parents onto `openy_system.openy_integrations_activenet` (from the
  OpenY / YMCA distro; the link's parent is external to this module).
- **One permission:** `administer activenet` (`activenet.permissions.yml`).
- **No** entities, plugins, blocks, fields, hooks (empty `activenet.module`), Drush, or cron.

## Mechanism (from source)

- `ActivenetClientFactory::get()` reads `base_uri`/`api_key` from `activenet.settings`, constructs the
  Guzzle client with `base_uri` + default headers (`Accept: application/json`,
  `page_info: {"total_records_per_page":200}`), then calls `$client->setApi(['base_uri'=>…, 'api_key'=>…])`.
- `ActivenetClient::__call($method, $args)` (magic) maps a `getX()` name to an endpoint path, injects
  `api_key` into the query args, builds `?…` with `http_build_query`, and calls the private
  `makeRequest('get', $base_uri . <path> . $suffix)`.
- `makeRequest()` runs `$this->request()`, checks for HTTP 200, `json_decode`s the body and returns
  `$object->body`; any failure throws `ActivenetClientException` (`src/ActivenetClientException.php`).
- `getActivityDetail(int $id)` is an explicit (non-magic) method hitting `activities/{id}`.

## Methods (via `__call` unless noted)

`getCenters`, `getSites`, `getActivities`, `getActivityTypes`, `getActivityCategories`,
`getActivityOtherCategories`, `getFlexRegPrograms`, `getFlexRegProgramTypes`, `getMembershipPackages`,
`getMembershipCategories` (all take an optional `array $args` of query params), and
`getActivityDetail(int $id)` (explicit). Note `getActivityCategories()` is advertised in the README/
docblock but has a `case` in `__call`; `getMembershipCategories` maps to the
`membershippackagecategories` path. See [api/client.md](api/client.md) for the exact path table and a
correct usage snippet (the README's `new $ActiveNetClient()` example is wrong — use the service).
