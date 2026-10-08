# Programmatic API — Subscription service, status, telemetry, events

## The Subscription service — `acquia_connector.subscription`

`Drupal\acquia_connector\Subscription` is the public entry point other Acquia modules use.

```php
/** @var \Drupal\acquia_connector\Subscription $sub */
$sub = \Drupal::service('acquia_connector.subscription');

$sub->hasCredentials();            // TRUE if identifier + key + application UUID all present
$sub->isActive();                  // TRUE if the subscription is active (fetches if stale)
$data = $sub->getSubscription();   // raw subscription data array (cached in state)
$data = $sub->getSubscription(TRUE); // force refresh from the Acquia Cloud API
$settings = $sub->getSettings();   // Drupal\acquia_connector\Settings (id, key, app UUID)
$sub->delete();                    // scrub cached subscription data from state
$sub->connectionErrorMessage($errno); // human message for an Acquia error code
```

`getSubscription()` calls the Acquia Cloud API (`/api/applications/{uuid}` then
`/api/subscriptions/{uuid}`) via `acquia_connector.client.factory` (`ClientFactory`), stores
the result in state key `acquia_connector.subscription_data`, and invalidates the
`acquia_connector_subscription` cache tag. Without credentials it returns `['active' => FALSE]`.
Error codes are class constants: `NOT_FOUND` (1000), `KEY_MISMATCH` (1100), `EXPIRED` (1200),
`VALIDATION_ERROR` (1800), etc.

## Status endpoint — `StatusController`

- `acquia_connector.status` → `/system/acquia-connector-status` returns JSON
  (`maintenance_mode`, `cache`, `block_cache`) for Acquia uptime monitoring. Access is a
  custom check: the request must carry `nonce` and a `key` equal to
  `sha1("{application_uuid}:{nonce}")`.
- `acquia_connector.refresh_status` re-fetches subscription data (heartbeat) then redirects to
  `system.status`.

## Telemetry — `acquia_connector.telemetry_service`

`Drupal\acquia_connector\Services\AcquiaTelemetryService` logs anonymized data via the logger.

```php
\Drupal::service('acquia_connector.telemetry_service')
  ->sendTelemetry('My event', ['extra' => 'value']);
```

Payload: enabled/available contrib + core modules and versions, profiles, PHP version, Drupal
version, and a **hashed** site UUID as `user_id` (no PII). Guardrails in
`shouldSendTelemetryData()`: only from a detected **Acquia production** env
(`AH_SITE_ENVIRONMENT` = `prod`/`*live`), at most once per **24 hours** per event, and skipped
when the payload hash is unchanged. `getAcquiaExtensionNames()` returns Acquia-family module
names. Telemetry is also auto-sent on `hook_modules_installed` / `hook_modules_uninstalled`.

## Events

Fired by the subscription service / settings form (constants on `AcquiaConnectorEvents`):

| Constant | Value | Use |
|---|---|---|
| `GET_SETTINGS` | `acquia_connector_get_settings` | Supply subscription credentials (`AcquiaSubscriptionSettingsEvent`) |
| `GET_SUBSCRIPTION` | `acquia_connector_get_subscription` | Add metadata/product data to subscription (`AcquiaSubscriptionDataEvent`) |
| `ACQUIA_PRODUCT_SETTINGS` | `acquia_connector_get_product_settings` | Inject per-product fields into the settings form |
| `ALTER_PRODUCT_SETTINGS_SUBMIT` | `acquia_connector_alter_product_settings_submit` | Handle per-product form submit values |

## Drush

`drush.services.yml` registers two commands: subscription **refresh**
(`RefreshSubscription`, uses the subscription service + state) and **SQL sanitize**
(`SqlSanitizeCommands`, clears Acquia state on `sql:sanitize`).
