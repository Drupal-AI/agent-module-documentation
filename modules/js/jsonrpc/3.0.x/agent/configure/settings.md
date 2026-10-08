# Settings — allowed authentication providers

Form: `Drupal\jsonrpc\Form\JsonRpcConfigurationForm` at `/admin/config/system/jsonrpc`
(route `jsonrpc.settings`, permission `administer jsonrpc`). Config object `jsonrpc.settings`.

The form only chooses which authentication providers are permitted on the `/jsonrpc` endpoint. On save, the
route subscriber (`JsonRpcRouteSubscriber`, reacting to config) rewrites the route's `_auth` option from these
flags, so the change takes effect after a router rebuild (`drush cr` / route rebuild).

| Key | Type | Default | Provider |
|---|---|---|---|
| `basic_auth` | bool | `TRUE` | HTTP Basic auth (needs core `basic_auth`) |
| `oauth2` | bool | `TRUE` | OAuth2 (needs the `simple_oauth`/oauth2 provider) |
| `cookie` | bool | `FALSE` | Drupal session cookie |
| `jwt` | bool | `FALSE` | JWT (needs the `jwt` module) |

Notes:
- Enabling a provider whose module is not installed has no effect (the provider simply isn't available).
- `cookie` is off by default; enabling it makes the endpoint reachable with an ordinary browser session.
- The `JsonRpcSetting` enum (`src/Enum/JsonRpcSetting.php`) names these settings (note its `Jwt` case value is
  `jwt_auth` while the stored config key is `jwt`).

```bash
ddev drush cget jsonrpc.settings
ddev drush config:set jsonrpc.settings cookie true -y && ddev drush cr
```
