<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The MetaClient service and hooks

## Service
`meta_conversions_api.meta_client` → `Drupal\meta_conversions_api\Services\MetaClient`
(interface `MetaClientInterface`). Constructor initialises the SDK only when `enabled` config is true
and an `access_token` is present:

```php
$this->api = \FacebookAds\Api::init(NULL, NULL, $accessToken, FALSE);
```

Note: `Api::init($app_id, $app_secret, $access_token, $log_crash)`. The final `FALSE` disables the
SDK's crash logging — it is **not** a TLS or app-secret-proof flag. No app id/secret is used; auth is
the access token alone. TLS verification on the event request path is left at the SDK default (on).

### `sendRequest(array $eventData, array $userData = [], array $customData = [], ?string $testEventCode = NULL): void`
The only send method. Steps (see `src/Services/MetaClient.php:203`):
1. Returns early unless `isEnabled()` (SDK initialised, `enabled` true, `pixel_id` set) and
   `isAllowed()` (no `hook_meta_conversions_api_allowed` implementation forbade it).
2. Requires `$eventData['event_name']`; logs an error and returns if missing.
3. Skips the event if it is toggled off (`isEventEnabled()`), and applies any rename from
   `eventNames()`.
4. Builds `UserData($userData)`; if `client_ip_address` / `client_user_agent` are absent it fills them
   from `$_SERVER['REMOTE_ADDR']` / `$_SERVER['HTTP_USER_AGENT']`.
5. Builds `CustomData($customData)`; a `content` key is wrapped in a `Content` object.
6. Builds `Event($eventData)`, defaulting `event_time` (now), `action_source` (`website`) and
   `event_source_url` (current request URL) when unset.
7. Sends `EventRequest($pixel_id)->setEvents([$event])->setTestEventCode($code)->execute()`, i.e. POST
   to `https://graph.facebook.com/v15.0/{pixel_id}/events`. Exceptions are caught and logged, never
   rethrown.

**PII hashing:** you pass raw values in `$userData` (`email`, `phone`, `first_name`, `last_name`, …).
The SDK's `UserData`/`Normalizer` SHA-256 hashes the fields Meta requires before they leave the site.
Do not pre-hash. `client_ip_address` and `client_user_agent` are sent unhashed by design.

Example (from README):
```php
\Drupal::service('meta_conversions_api.meta_client')->sendRequest(
  ['event_name' => 'Purchase', 'event_id' => 'order-' . $order_id],
  ['email' => 'buyer@example.com', 'phone' => '+15551234567'],
  ['currency' => 'USD', 'value' => 42.00]
);
```

### Other methods
- `isEnabled(): bool` — SDK ready + `enabled` + `pixel_id`.
- `isAllowed(): bool` — OR-reduces all `hook_meta_conversions_api_allowed` results; blocked only if the
  combined result `isForbidden()`. Statically cached per request.
- `eventNames(): array` — collects `hook_meta_conversions_api_event_names`, applies the alter hook,
  caches permanently under `meta_conversions_api_event_names`.
- `isEventEnabled($name): bool` — false only if the `event_toggles` config sets it explicitly false.

## Hooks (`meta_conversions_api.api.php`)
- `hook_meta_conversions_api_event_names(): string[]` — declare event names so they can be toggled/renamed. Core declares `PageView`.
- `hook_meta_conversions_api_event_names_alter(array &$names)` — rename events (`$names['X'] = 'Y'`).
- `hook_meta_conversions_api_allowed(): AccessResultInterface` — return `AccessResult::forbiddenIf(!$consent)` to block all sending. The consent integration point.

## Twig
`MetaApiTwig` (service `meta_conversions_api.twig.meta_api_twig`) exposes `meta_api_is_enabled()` and
`meta_api_is_allowed()` for templates.
