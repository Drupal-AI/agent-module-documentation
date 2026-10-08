<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ActiveNet client service (`activenet.client`)

How to install, configure and consume the ActiveNet API client. All behaviour comes from four small
classes under `src/` plus `activenet.services.yml`, `activenet.routing.yml`, `activenet.permissions.yml`,
`config/install/activenet.settings.yml`.

## Install / enable

`drush en activenet -y`. No Composer requirements, no module dependencies. The module is packaged
under the *YMCA Website Services* (OpenY) distro; its settings menu link expects the OpenY parent
`openy_system.openy_integrations_activenet`, but the module works standalone (the link just won't
have a parent tab without OpenY).

## Configuration

- **Route:** `activenet.settings` → path `/admin/openy/integrations/activenet/settings`, form
  `Drupal\activenet\Form\SettingsForm` (`getFormId()` = `activenet_admin_settings`), permission
  `administer activenet`.
- **Config object:** `activenet.settings` (simple config; install defaults `base_uri: ''`,
  `api_key: ''`). **No `config/schema/`** ships — so there is no typed-config schema for these keys.
- **Fields:**
  - `base_uri` (`#type: url`) — ActiveNet API base, format
    `https://{host}/{service}/{org id}/api/{version}/`. On submit, `SettingsForm::submitForm()`
    prepends `https://` when no scheme is present (`preg_match("#https?://#", …) === 0`) and appends a
    trailing `/` (`rtrim($base_uri,'/') . '/'`).
  - `api_key` (`#type: textfield`) — the ActiveNet key string. Stored as-is in config.

## Service wiring

```yaml
# activenet.services.yml
activenet.client:
  class: Drupal\activenet\ActivenetClient
  factory: activenet.client.factory:get
activenet.client.factory:
  class: Drupal\activenet\ActivenetClientFactory
  arguments: ['@config.factory']
```

`ActivenetClientFactory::get()` (`src/ActivenetClientFactory.php`):

1. Loads `activenet.settings`.
2. Builds the Guzzle config: `base_uri` + headers `Accept: application/json`,
   `page_info: '{"total_records_per_page":200}'`.
3. `new ActivenetClient($config)` then `$client->setApi(['base_uri'=>…, 'api_key'=>…])`.

`ActivenetClient` (`src/ActivenetClient.php`) **extends `GuzzleHttp\Client`** and implements the empty
marker interface `ActivenetClientInterface`. TLS peer verification is Guzzle's default (**on**) — the
module never sets `verify => false`.

## How a call works

- Magic `__call($method, $args)`: requires `apisettings` (throws `ActivenetClientException` otherwise),
  puts `api_key` into `$args[0]['api_key']`, serialises with `http_build_query` into a `?…` suffix,
  and dispatches on `$method` to `makeRequest('get', $base_uri . <path> . $suffix)`.
- `makeRequest()` (private): calls `$this->request()`, requires HTTP 200 and a non-empty body,
  `json_decode`s it, and returns `$object->body`. Anything else → `ActivenetClientException` whose
  message includes the request URI.

## Method → endpoint path

| Method | Path (relative to `base_uri`) |
| --- | --- |
| `getCenters($args)` | `centers` |
| `getSites($args)` | `sites` |
| `getActivities($args)` | `activities` |
| `getActivityTypes($args)` | `activitytypes` |
| `getActivityCategories($args)` | `activitycategories` |
| `getActivityOtherCategories($args)` | `activityothercategories` |
| `getFlexRegPrograms($args)` | `flexregprograms` |
| `getFlexRegProgramTypes($args)` | `flexregprogramtypes` |
| `getMembershipPackages($args)` | `membershippackages` |
| `getMembershipCategories($args)` | `membershippackagecategories` |
| `getActivityDetail(int $id)` | `activities/{id}` (explicit method, not via `__call`) |

Each `$args` is an optional associative array of ActiveNet query parameters (paging, filters);
`api_key` is added automatically. `getMembershipCategories` intentionally maps to the
`membershippackagecategories` path.

## Consume it (correct pattern)

The README's `new $ActiveNetClient()` snippet is broken — instantiate via the container, not `new`:

```php
/** @var \Drupal\activenet\ActivenetClient $client */
$client = \Drupal::service('activenet.client');   // or inject 'activenet.client'
try {
  $centers = $client->getCenters();               // decoded ->body of the response
  $activity = $client->getActivityDetail(12345);
}
catch (\Drupal\activenet\ActivenetClientException $e) {
  // handle/log — but see caveat below before logging the message
}
```

Returned values are whatever ActiveNet puts under the JSON `body` key (plain decoded objects/arrays).
Treat them as untrusted external content: escape on output, and validate before mapping into entities.

## Caveats

- **No caching / rate-limiting** in the module — every call is a live HTTP request. Cache in your
  consuming code.
- **`getActivityCategories()`** appears in the README and class docblock; it is handled by a `case` in
  `__call` but is **not** in the `@method` docblock list — call it defensively.
- `ActivenetClientException` messages embed the full request URI. Prefer logging a static message plus
  the endpoint name rather than the raw exception message.
- `base_uri` accepts `http://` if an admin types it that way (the form only auto-adds `https://` when
  no scheme is present) — always configure an `https://` base.
