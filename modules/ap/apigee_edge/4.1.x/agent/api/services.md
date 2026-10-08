# Services / SDK client / entity controllers

All Apigee data access goes through the SDK connector and a set of entity **controllers** that wrap
`apigee/apigee-client-php`. Use these rather than talking to Apigee directly.

## Core service — `apigee_edge.sdk_connector` (`SDKConnector`)

Builds and caches the Apigee SDK `Client`.

```php
/** @var \Drupal\apigee_edge\SDKConnectorInterface $connector */
$connector = \Drupal::service('apigee_edge.sdk_connector');
$org    = $connector->getOrganization();      // active org name
$client = $connector->getClient();            // \Apigee\Edge\ClientInterface (authed)
$connector->testConnection($optionalKey);     // throws on failure
```
Key methods: `getClient(?Authentication, ?endpoint)`, `buildClient()`, `getOrganization()`,
`testConnection()`. Credentials come from the active Key (`apigee_edge.auth:active_key`); the client
is built on Drupal's `http_client_factory` with the timeouts/proxy from
`apigee_edge.client`. A per-request user-agent is assembled and can be extended by
`hook_apigee_edge_user_agent_string_alter()`.

## Entity controllers (SDK wrappers, with caching)

| Service id | Class | Purpose |
|---|---|---|
| `apigee_edge.controller.organization` | `OrganizationController` | Load the org. |
| `apigee_edge.controller.developer` | `DeveloperController` | CRUD Apigee developers. |
| `apigee_edge.controller.api_product` | `ApiProductController` | List/load API products. |
| `apigee_edge.controller.app` | `AppController` | Apps across the org. |
| `apigee_edge.controller.developer_app_controller_factory` | `DeveloperAppControllerFactory` | Per-developer app controller. |
| `apigee_edge.controller.developer_app_credential_factory` | `DeveloperAppCredentialControllerFactory` | App credentials / API keys (dispatches credential events). |

These are backed by in-memory caches (`apigee_edge.controller.cache.*`, `MemoryCacheFactory`) and the
`apigee_edge_entity` cache bin. Entity queries use `entity.query.edge` (`QueryFactory`).

## Other notable services

- `apigee_edge.job_executor` (`JobExecutor`) + `src/Job/*` + a QueueWorker — runs long operations
  (e.g. developer sync) as chunked background jobs.
- `apigee_edge.converter.user_developer` (`UserDeveloperConverter`) and
  `apigee_edge.converter.field_attribute` (`FieldAttributeConverter`) — map Drupal user fields ↔
  Apigee developer attributes.
- `apigee_edge.authentication.oauth_token_storage` (`OauthTokenFileStorage`) — OAuth token cache
  (see [../configure/connection.md](../configure/connection.md)).
- `apigee_edge.data_residency_endpoint` (`DataResidencyEndpoint`) — resolves the Apigee X data
  residency (region) endpoint.
- `apigee_edge.entity.app_warnings_checker` (`AppWarningsChecker`) — surfaces app credential/product
  status warnings.
- Event subscribers: `EdgeExceptionSubscriber` (routes API errors to the error page),
  `DeveloperStatusWarningSubscriber`, `ApiProductEntityAccessCacheReset`.

## Access checks
- `_app_access_check_by_app_name` → `AppAccessCheckByAppName` (route requirement).
- `ExportAnalyticsController::access` guards the CSV analytics export route
  (`/analytics/export/{data_id}/csv`, also `_csrf_token`).
