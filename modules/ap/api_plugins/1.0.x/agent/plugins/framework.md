<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Plugins — building and calling plugins

## Define a plugin
Create a plugin class extending `ApiPluginBase` (or `AiApiPluginBase`) annotated with `#[ApiPlugin]`. Implement the surface used by `ApiRequestService`: `prepareForRequest($params)`, `preparePayload($params)`, `getEndpoint()`, `getHttpMethod()`, `getHeaders()`.

## Call a plugin
```php
$result = \Drupal::service('api_plugins.request')->sendRequest($plugin_id, $params);
```
`ApiRequestService::sendRequest()`:
1. Instantiates the plugin, calls `prepareForRequest()` then `preparePayload()`.
2. Resolves endpoint/method/headers; runs `hook_api_plugins_prepare_payload` alter.
3. Issues the call via core `http_client` (Guzzle, TLS verified) with validated `timeout`/`connect_timeout`.
4. Decodes JSON, wraps failures in typed exceptions: `ApiAuthenticationException`, `ApiConnectionException`, `ApiRateLimitException`, `ApiResponseException`, `ApiTimeoutException`, `ApiConfigurationException`.

## Authentication (`ApiAuthenticationService`)
Register provider auth with `hook_api_plugins_authentication_info()` returning `auth_type` (bearer/custom/none), `config_key`, `env_var`, `header_name`. `getAuthentication($provider)` reads the credential from a **Key entity** first, then the environment variable, and formats the header. Register the selectable key in the settings form with `hook_api_plugins_api_key_info()`.

Config `api_plugins.settings` holds only `api_keys` (Key entity IDs) and timeouts — no raw secrets. Submodules `api_plugins_openai`, `api_plugins_anthropic`, `api_plugins_mcp` are reference implementations of these hooks.
