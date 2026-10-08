<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services API

Two services, both usable from custom code.

## `aweber_block.authentication` — `Service\AweberAuthentication`

Implements `AweberAuthenticationInterface`. Args: `@config.factory`, `@http_client` (Guzzle), `@datetime.time`. Wraps the `aweber_block.aweberblockconfig` object and the OAuth2 token lifecycle.

- `buildAuthorizationUrl()` — returns the AWeber authorize URL: `auth_request_url` + query (`response_type=code`, `client_id`, `redirect_uri`, space-joined `scope` from selected `AweberScopes::SCOPES`, `state`).
- `getAccessToken($code)` — Guzzle `POST https://auth.aweber.com/oauth2/token`, HTTP Basic `auth => [client_id, client_secret]`, query `grant_type=authorization_code`, `code`, `redirect_uri`. Returns the raw response body (JSON string) or `null` on `GuzzleException` (logged via `\Drupal::logger('aweber_block')`).
- `refreshAccessToken()` — same endpoint with `grant_type=refresh_token` + stored `refresh_token`; returns a decoded object or `null`.
- `saveAccessToken($tokenObject)` — writes `auth_token` (`access_token`), `refresh_token`, and `expires_in` (= `$tokenObject->expires_in` + current time) to config.
- `getStoredAccessToken()` — returns the current access token; if `current time > expires_in` it refreshes first, saves, and returns the new token.
- `getHttpClient()`, `getBaseUrl()` (`base_url`), `getAccountId()` (`aweber_account_id`) — accessors.

TLS: token requests use Guzzle defaults (certificate verification enabled). Note the token endpoint is hard-coded (`https://auth.aweber.com/oauth2/token`) and ignores `auth_request_url`.

## `aweber_block.manager` — `Service\AweberManager`

Implements `AweberServiceInterface`. Arg: `@aweber_block.authentication`. In its constructor it eagerly pulls `baseUrl`, the HTTP client, the current access token (`getStoredAccessToken()`), and the account id from the auth service. All calls send `Authorization: Bearer <token>`.

- `accounts()` — `GET {base}/accounts`; returns the `entries` array (the authorized AWeber account(s)).
- `lists(int $accountID)` — `GET {base}/accounts/{accountID}/lists`; returns an `id => name` map.
- `addSubscribers(int $listID, array $params)` — `POST {base}/accounts/{accountId}/lists/{listID}/subscribers` with `json => $params` (e.g. `['email' => ...]`). Returns TRUE, or FALSE on `ClientException`.
- `checkSubscriberExistsByEmail($email, int $listId)` — `GET .../subscribers?ws.op=find&email={email}`; returns TRUE when no entries match (email absent), FALSE when it already exists or on error.

Private helpers `get()`/`post()` catch Guzzle exceptions and log to channel `Aweber_block`.

## Example (custom code)

```php
$manager = \Drupal::service('aweber_block.manager');
$accounts = $manager->accounts();
$accountId = $accounts[0]['id'];
$lists = $manager->lists($accountId);        // [listId => name]
$listId = array_key_first($lists);
if ($manager->checkSubscriberExistsByEmail('user@example.com', $listId)) {
  $manager->addSubscribers($listId, ['email' => 'user@example.com']);
}
```

The site must already be OAuth-authorized (valid `auth_token`/`refresh_token` in config) for any of these to succeed.
