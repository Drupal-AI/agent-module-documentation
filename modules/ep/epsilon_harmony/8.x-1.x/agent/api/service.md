<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Epsilon Harmony API service

Service id **`epsilon_harmony.api_service`** (`epsilon_harmony.services.yml`, no arguments) →
`Drupal\epsilon_harmony\Services\EpsilonApiFactory`, which **extends**
`Drupal\epsilon_harmony\Services\EpsilonConnectionFactory`.

```php
$service = \Drupal::service('epsilon_harmony.api_service');
```

The parent constructor reads `epsilon_harmony.settings` config and builds the connection
(credentials, X-OUID, region → base URLs, decoded list/message maps) each time the service is
instantiated. All calls use `\Drupal::httpClient()` (Guzzle, default TLS verification).

## Methods (`EpsilonApiFactory`)

| Method | HTTP | Endpoint (relative to region `apiUrl`) |
|---|---|---|
| `createRecord(array $record)` | POST | `/v4/profiles/records` |
| `updateRecord(array $record)` | PUT | `/v4/profiles/records/{CustomerKey}` |
| `deleteRecord($customer_key)` | DELETE | `/v4/profiles/records/{key}` |
| `retrieveRecord($customer_key)` | GET | `/v4/profiles/records/{key}` |
| `createListRecord(array $record, $list_id = NULL)` | POST | `/v4/lists/{resolvedListId}/records` |
| `updateListRecord(array $record, $list_id = NULL)` | PUT | `/v4/lists/{resolvedListId}/records/{CustomerKey}` |
| `sendMessage($message_id = NULL, array $record = [])` | PUT | `/v3/messages/{resolvedMessageId}/send` |
| `testApi()` | — | forces a fresh token (`getToken($this, TRUE)`) |
| `getToken($object, $test = FALSE)` *(static)* | POST | `{tokenUrl}/Epsilon/oauth2/access_token` |
| `logEpsilon(array $record)` *(protected)* | — | creates an `epsilon_harmony_log` entity |

Notes:
- `$record['CustomerKey']` is the only mandatory field for profile create/update; `updateRecord`,
  `updateListRecord` build the URL from it. `deleteRecord`/`retrieveRecord` take the key string.
- `$list_id` / `$message_id` are the **friendly identifiers** you defined on the list/message
  config forms; `getlistId()` / `getmessageId()` resolve them to the real Epsilon IDs and throw
  if the identifier is unknown.
- Each method logs the call and shows a status/error message linking to the created log entity;
  most return the decoded response array on `HTTP 200`.

## OAuth2 token flow (`getToken()`)

1. Reuses the cached token unless `$test` is TRUE, or `epsilon_harmony_token_timeout` state is
   unset, or more than 3600s old.
2. POSTs `grant_type=password` form params (`username`, `password`, fixed `scope`) with an
   `Authorization: Basic base64(clientId:secretKey)` header (`getBaseToken()`).
3. On 200 stores the access token + timestamp in `\Drupal::state()`
   (`epsilon_harmony_access_token`, `epsilon_harmony_token_timeout`) and returns the token.
4. Profile/list/message calls send `Authorization: Bearer {token}` + `X-OUID` headers.

## Errors / logging

Every call wraps in try/catch (`GuzzleHttp\Exception\ClientException`) and calls
`logEpsilon()`, persisting `endpoint, uid, method, status_code, status_message, header, request,
response` to the `epsilon_harmony_log` entity. See [../entity/logs.md](../entity/logs.md). HTTP
status constants live in `src/StatusCodes.php` (`StatusCodes::HTTP_OK`, etc.).
