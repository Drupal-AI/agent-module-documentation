# Configure — settings, credentials, logging

Settings form `Drupal\trustpilot_api\Form\SettingsForm` at route `trustpilot_api.settings`
(`/admin/config/services/trustpilot-api`), gated by core permission **`administer site
configuration`**. It is a `ConfigFormBase` editing the single config object **`trustpilot_api.settings`**.

## Config keys (`trustpilot_api.settings`)

| Key | Schema type | Install default | Meaning |
|---|---|---|---|
| `api_key` | string | `''` | Trustpilot API key. Sent as the `apiKey` **request header** on every call, and as the HTTP-basic username during OAuth token exchange. |
| `api_secret` | string | *(none in install yml)* | Trustpilot API secret. Used as the HTTP-basic password during OAuth token exchange. Required for `oauth` (private) endpoints. |
| `oauth_email` | email | `''` | Trustpilot b2b login email. Password-grant `username`. |
| `oauth_password` | string | `''` | Trustpilot b2b login password. Password-grant `password`. |
| `business_unit_id` | string | `''` | Default `businessUnitId` used when an endpoint requires it and no per-request value is given (see `EndpointPluginBase::setRequestParams()`). |
| `logging_enabled` | boolean | `false` | When on, `TrustpilotApiClient` writes an `info` log per request/token-exchange to the `trustpilot_api` channel. |
| `client_connect_timeout` | float | `0` | Guzzle `connect_timeout` (seconds) for the client. |

`canAuthorizePrivate()` returns TRUE only when `api_key`, `api_secret`, `oauth_email` **and**
`oauth_password` are all set — that is the precondition for any `authType = oauth` endpoint.

## Where the credentials go (recommended: not in config)

The form itself recommends keeping the secrets **out of exported config** by overriding them in
`settings.php` (config override), e.g.:

```php
$config['trustpilot_api.settings']['api_key'] = getenv('TRUSTPILOT_API_KEY');
$config['trustpilot_api.settings']['api_secret'] = getenv('TRUSTPILOT_API_SECRET');
$config['trustpilot_api.settings']['oauth_password'] = getenv('TRUSTPILOT_OAUTH_PASSWORD');
```

A `settings.php` override wins over stored config at read time, so you can leave those fields blank
in the form. (Note: the form renders each value in a plain `textfield`, and the client reads them via
`$config->get(...)`, so an override is the way to avoid persisting secrets in the config store /
config export.)

## Test forms (same permission)

- `trustpilot_api.test` (`Form\TestForm`, path `…/test`) — a table of every endpoint plugin with a
  "Quick Test Endpoints" bulk action and a "Test OAuth Connection" button (calls
  `business_unit_private_reviews`). Reports only Success/Failed per endpoint.
- `trustpilot_api.test_endpoint` (`Form\TestEndpointForm`, path `…/test/endpoint/{endpoint_id}`,
  `endpoint_id` constrained to `[a-z\_]+`) — builds one text field per required/default request param
  and performs a single live request, printing the returned array.

Both are developer/debug tools; nothing here is meant for end users.
