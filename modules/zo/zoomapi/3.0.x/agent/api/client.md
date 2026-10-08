# Zoom API client (`zoomapi.client`)

`Drupal\zoomapi\Plugin\ApiTools\Client` extends apitools `ClientBase` (parent service
`apitools.client_base`). It is the object you use to make authenticated calls to the Zoom REST API.
Inject the `zoomapi.client` service or fetch it statically:

```php
/** @var \Drupal\zoomapi\Plugin\ApiTools\Client $client */
$client = \Drupal::service('zoomapi.client');

// GET https://api.zoom.us/v2/users
$users = $client->get('users');

// POST with a JSON body.
$meeting = $client->post('users/me/meetings', [
  'json' => [
    'topic' => 'Standup',
    'type' => 2,
  ],
]);
```

HTTP verb methods (`get`, `post`, `patch`, `put`, `delete`, and the generic `request`) are inherited
from apitools `ClientBase`; the first argument is an endpoint **relative to** `base_uri`/`base_path`
(so `users` → `https://api.zoom.us/v2/users`), the second an options array (Guzzle-style, e.g.
`json`, `query`, `form_params`). Successful responses are **JSON-decoded to a PHP array** —
`Client::postRequest()` runs `Json::decode()` on the body. On HTTP errors Guzzle throws a
`GuzzleHttp\Exception\RequestException`, so wrap calls in try/catch (see the module's
`tests/src/Functional/ApiRequestTest.php`).

## Authentication flow (Server-to-Server OAuth)

Authentication is transparent — you never request a token yourself. Before a call, `Client::auth()`
calls `ensureAccessToken()`, which:

1. Returns the cached `access_token` if apitools still holds a non-expired one.
2. Otherwise POSTs to `auth_token_url` (`https://zoom.us/oauth/token`) with HTTP Basic auth
   `[client_id, client_secret]` and `form_params` `account_id` + `grant_type=account_credentials`
   (Zoom's `account_credentials` grant).
3. On a response with `token_type === 'bearer'`, stores `access_token` with its `expires_in` TTL.

`auth()` then sets the request header `authorization: Bearer <access_token>`. `client_secret` is
read from its Key entity via apitools config resolution (see [../configure/settings.md](../configure/settings.md)).

## `validateConfiguration()`

```php
public function validateConfiguration(): bool
```

Returns `FALSE` when `account_id`, `client_id`, or `client_secret` is empty; otherwise attempts
`ensureAccessToken()` and returns the token (truthy) or `FALSE`. Used by the module's
`hook_requirements()` to surface a "Missing valid configuration" runtime error.

## `defaultConfiguration()`

Adds the plugin defaults merged over apitools' base: `base_uri = https://api.zoom.us`,
`base_path = v2`, `auth_token_url = https://zoom.us/oauth/token`. Override any of them on the config
object `apitools.client.zoomapi`.

## Notes

- The `zoomapi` plugin is an **API Tools client instance**, not a new plugin type — it is discovered
  by apitools' `@ApiToolsClient` annotation (id `zoomapi`, `api = "zoomapi"`).
- `ZoomapiServiceProvider::alter()` removes the `zoomapi.client` definition if `apitools.client_base`
  is not present, so the container still builds when apitools is missing.
