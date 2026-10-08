<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API Connection example code (api_connection_example) — agent index

Hidden reference submodule of **api_connection** demonstrating a `RestApiConnection` integration
against the public **ReqRes.in** test service. `type: module`, `hidden: TRUE`, depends on
`api_connection:api_connection`. Core `^9 || ^10 || ^11`. No permissions, config, services or
plugin types of its own. Version **1.0.0-beta2**.

## What it provides (from source)

- **Connection plugin `ReqRes`** (id `req_res`) — `src/Plugin/RestApiConnection/ReqRes.php`,
  extends `RestApiConnectionBase`, attribute `#[RestApiConnection]` with label `'REQ|RES API'` and
  `urls` all set to `https://reqres.in` for `dev`/`test`/`live`. Methods:
  - `getUser(int $id): array` → `sendRequest("api/users/{$id}", "GET")`.
  - `login(string $username, string $password): bool|string` → POST `api/login` with a
    `RequestOptions::BODY` of `email`/`password`; returns `$response['token']` or `FALSE`.
- **Controller `ReqResController`** — `src/Controller/ReqResController.php`, extends
  `ControllerBase`; `create()` obtains the plugin via
  `plugin.manager.rest_api_connection->createInstance('req_res')`. Methods `login()` and
  `userDetail($id = 1)` build render arrays with `t()` placeholders (`@token`, `@first`/`@last`).
- **Routes** (`api_connection_example.routing.yml`), both `_permission: 'access content'`:
  - `api_connection_example.req_res_login` — `/api_connection_example/login` → `::login`.
  - `api_connection_example.req_res_user_details` — `/api_connection_example/reqres/{id}`
    (default `id: 1`) → `::userDetail`.

## Solution doc

- **The ReqRes plugin, its methods, the controller & routes** →
  [plugins/reqres.md](plugins/reqres.md)

Parent module index: [../../../../agent/start.md](../../../../agent/start.md).
