# Connect Drupal to Apigee

The connection is a **Key** entity (module dependency) plus two small config objects. There is no
plaintext-in-config credential path — credentials always live in a Key.

## The auth Key (`apigee_auth` key type)

`\Drupal\apigee_edge\Plugin\KeyType\ApigeeAuthKeyType` (`@KeyType id = "apigee_auth"`) is a
multivalue key type whose fields are the Apigee credentials:

| Field | Meaning |
|---|---|
| `instance_type` | `public` / `private` (Edge) or `hybrid` (Apigee X / hybrid). |
| `auth_type` | `basic` or `oauth` (Edge only; hybrid always uses OAuth/JWT). |
| `organization` | Apigee org name (**required**). |
| `username` / `password` | Edge basic/OAuth credentials. |
| `client_id` / `client_secret` | OAuth client for Edge OAuth (optional; SDK defaults if empty). |
| `authorization_server` | OAuth token endpoint (optional). |
| `endpoint` | Apigee Management API base URL (optional; SDK default per instance type). |
| `account_json_key` | GCP service-account JSON (hybrid). |
| `gcp_hosted` | Use the default GCE service account when hosted on GCP (hybrid). |

The key **input** plugin is `apigee_auth_input` (`ApigeeAuthKeyInput`); it renders the right fields
per instance/auth type. `validateKeyValue()` requires valid JSON and the required fields.

### Where the key value is stored — key providers
`SDKConnector::buildCredentials()` picks a credentials class from the key:
`HybridCredentials`, `OauthCredentials`, or `Credentials` (basic). The **provider** decides where the
JSON is physically kept. Two Apigee-specific providers ship (any core Key provider also works):

- `apigee_edge_environment_variables` (`EnvironmentVariablesKeyProvider`) — reads each field from an
  environment variable via `getenv()`; nothing is written to the DB. Recommended for secrets.
- `apigee_edge_private_file` (`PrivateFileKeyProvider`) — stores the value as
  `private://.apigee_edge/{key_id}.json` (requires the private filesystem to be configured).

## Selecting the active key

Form **`apigee_edge.settings`** (`AuthenticationForm`, `/admin/config/apigee-edge/settings`, task
label "Credentials") lets an admin fill in / create the key and **Save**, which writes
`apigee_edge.auth:active_key` = the key id. `SDKConnector::getCredentials()` loads that key; if it is
empty or missing it throws `AuthenticationKeyException` / `AuthenticationKeyNotFoundException`. A
**Test connection** step calls `SDKConnector::testConnection()` → loads the org via the SDK
`OrganizationController` to verify.

Set the active key with Drush/PHP:
```php
\Drupal::configFactory()->getEditable('apigee_edge.auth')
  ->set('active_key', 'apigee_auth_key')   // id of an existing apigee_auth Key entity
  ->set('oauth_token_storage_location', '') // optional; '' → private://.apigee_edge
  ->save();
```

## Connection tuning — `apigee_edge.client`

`ConnectionConfigForm` (`/admin/config/apigee-edge/connection-config`) edits config object
`apigee_edge.client`:

| Key | Default | Notes |
|---|---|---|
| `http_client_connect_timeout` | `30` | seconds |
| `http_client_timeout` | `30` | seconds |
| `http_client_proxy` | `''` | Guzzle `proxy` string |

`SDKConnector::httpClientConfiguration()` feeds these to Drupal's `http_client_factory`, which builds
the Guzzle client wrapped by the SDK `Client`. The SDK talks to the endpoint returned by the key type
(`getEndpoint()`), or the Apigee default per instance type.

## OAuth token cache

For OAuth/hybrid auth the access/refresh tokens are cached by service
`apigee_edge.authentication.oauth_token_storage` (`OauthTokenFileStorage`) at
`private://.apigee_edge/oauth.dat` (override via `apigee_edge.auth:oauth_token_storage_location`). The
storage requires the private filesystem to be configured and refreshes tokens automatically.

## Error page

`ErrorPageSettingsForm` (`/admin/config/apigee-edge/error-page-settings`) + config
`apigee_edge.error_page` control the page shown at route `apigee_edge.error_page`
(`/api-communication-error`) when the Apigee connection fails; `EdgeExceptionSubscriber` redirects
there. Keys: `error_page_title`, `error_page_content` (format/value), `error_page_debug_messages`.
