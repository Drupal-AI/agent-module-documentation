<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `crowd.connector` REST client

`Drupal\crowd\Crowd\CrowdConnector` implements `CrowdConnectorInterface`. It is the whole REST
client for Crowd's User Management API and the public integration point for custom code. Injected
as service **`crowd.connector`**.

Constructor args (from `crowd.services.yml`): `@http_client` (Guzzle), `@key.repository`,
`@config.factory`, `@logger.channel.crowd`, `@request_stack`.

## Endpoints (interface constants)

Base is `server_uri` from `crowd.settings`, then:
`REST_BASE_PATH = /rest` → `USER_MANAGEMENT_PATH = /rest/usermanagement/1` →
- `USER_PATH` = `…/user`
- `PASSWORD_PATH` = `…/user/password`
- `SESSION_PATH` = `…/session`
- `RESET_PASSWORD_PATH` = `…/user/mail/password`

Other constants: `PASSWORD_KEY_ID = 'crowd_password'`, `PROVIDER = 'crowd'`.

## Transport (`makeRequest`)

`makeRequest($path, $data = [], $method = 'GET')` calls
`$httpClient->request($method, buildUri($path), array_filter(['json' => $data, 'headers' => …,
'auth' => …]))`.

- `buildUri()` = `server_uri . $path`.
- `getHeaders()` = `Content-type: application/json`, `Accept: application/json`,
  `Connection: close`.
- `getAuthentication()` returns `[username-from-config, crowd_password-Key-value]` → Guzzle HTTP
  **Basic** auth. Throws `MissingKeyException` if the Key is absent.
- Uses Guzzle defaults for TLS (certificate verification on); no per-request TLS options are set.

## Public methods

| Method | HTTP → endpoint | Success | Returns |
|--------|-----------------|---------|---------|
| `login($username, $password)` | POST `SESSION_PATH` with `validation-factors` (remote_address = client IP) | 201 → re-fetches user, attaches `session` data | `CrowdResult` |
| `logout($username, $sessionToken)` | DELETE `SESSION_PATH/{token}` | 204 | `bool` |
| `register($username, $mail, $password, $given, $surname, $display='')` | POST `USER_PATH` (`active => FALSE`) | 201 → then calls `updateUserStatus(…, FALSE)` | `CrowdResult` |
| `updateUser($origUser, $username, $mail, $pass, $given, $surname, $display='')` | PUT `USER_PATH?username={orig}` (fields `array_filter`ed) | 204 → re-fetches user | `CrowdResult` |
| `updatePassword($username, $password)` | PUT `PASSWORD_PATH?username=…` `{value}` | 204 | `bool` |
| `updateUserStatus($username, $status=TRUE)` | PUT `USER_PATH?username=…` with `active` flag | 204 | `CrowdResult` |
| `getUser($username)` | GET `USER_PATH?username=…` | 200 | `?CrowdUser` |
| `userExists($username)` | GET `USER_PATH?username=…` | 200 → TRUE | `bool` |
| `isVerified($username)` | via `getUser` → `CrowdUser::isActive()` | — | `bool` |
| `passwordReset($username)` | GET `RESET_PASSWORD_PATH?username=…` (triggers Crowd reset email) | 204 | `bool` |

The `#[\SensitiveParameter]` attribute is applied to `register`'s `$password`. Passwords are
`trim()`ed before sending. `register` marks the account inactive after creation (Crowd bug
[CWD-3018] means it can't be created inactive directly); the user activates by clicking the email
verification link, which is honored on `user.reset.login` (see
[../integration/user-forms.md](../integration/user-forms.md)).

## Result / value objects

- **`CrowdResult`** (`src/Crowd/CrowdResult.php`): immutable, private constructor. Factories
  `forCrowdUser(CrowdUser)` and `failure(string $reason)`. Accessors `isSuccessful()`,
  `getName()`, `getMail()`, `getUserAttributes()` (raw Crowd data array), `getReason()`.
- **`CrowdUser`** (`src/Crowd/CrowdUser.php`): factory `fromResponseData($data)` (expects
  `name`, `email`); `getName()`, `getMail()`, `getData()`, `addData($key, $data)`,
  `setActiveState($bool)`, `isActive()` (reads `data['active']`).
- **`MissingKeyException`** (`src/Crowd/MissingKeyException.php`): `forKeyId($id)`.

## Error handling

Each method wraps the call in try/catch for `GuzzleHttp\Exception\RequestException` and generic
`\Exception`, logs to the `crowd` channel (login failures at `notice`, most others `error`/
`warning`), and returns a `CrowdResult::failure(...)` or `FALSE`/`NULL`. Unexpected status codes
are logged and treated as failure.
