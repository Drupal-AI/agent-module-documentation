<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `req_res` example connection & controller

Worked example of the `api_connection` framework. Enable with `drush en api_connection_example`
(the module is `hidden`, so it will not show in the default UI list).

## Plugin `ReqRes` — `src/Plugin/RestApiConnection/ReqRes.php`

```php
#[RestApiConnection(
  id: 'req_res',
  label: new TranslatableMarkup("'REQ|RES API'"),
  urls: [
    'dev'  => 'https://reqres.in',
    'test' => 'https://reqres.in',
    'live' => 'https://reqres.in',
  ]
)]
class ReqRes extends RestApiConnectionBase { ... }
```

- `getUser(int $id): array` — `return $this->sendRequest("api/users/{$id}", "GET");`. Returns the
  decoded JSON body (array). Full URL sent: `https://reqres.in/api/users/{id}`.
- `login(string $username, string $password): bool|string` — builds
  `[RequestOptions::BODY => ['email' => $username, 'password' => $password]]`, calls
  `sendRequest('api/login', 'POST', $options)`. `sendRequest()` JSON-encodes the body and sets
  `Content-Type: application/json`. Returns `$response['token']` if present, else `FALSE`.
- Both may throw `RestApiEnvironmentUrlException` (they don't here, since every environment has a
  URL).

## Controller `ReqResController` — `src/Controller/ReqResController.php`

- `create()` calls `parent::create()` then
  `$container->get('plugin.manager.rest_api_connection')->createInstance('req_res')`, storing it in
  `$this->reqResConnection`.
- `login()` — calls `$this->reqResConnection->login('eve.holt@reqres.in', 'cityslicka')` (hard-coded
  ReqRes demo credentials); renders `'Login successful! Token: @token'` or `'Login failed...'` via a
  `#markup` render element with a `t()` placeholder (auto-escaped).
- `userDetail($id = 1)` — calls `getUser((int) $id)` and, if non-empty, renders
  `'Name for user @id: @first @last'` from `$user_data['data']['first_name']` /
  `['last_name']` — again through `t()` placeholders (escaped).

## Routes — `api_connection_example.routing.yml`

- `api_connection_example.req_res_login` → `/api_connection_example/login`,
  `_controller ::login`, `_permission: 'access content'`.
- `api_connection_example.req_res_user_details` → `/api_connection_example/reqres/{id}`
  (default `id: 1`), `_controller ::userDetail`, `_permission: 'access content'`.

Both are read-only example displays that fetch data from ReqRes.in and render escaped strings; the
`{id}` slug is cast to `int` before use. This is demonstration code (`hidden: TRUE`) meant to be
copied into a custom module, not enabled in production.
