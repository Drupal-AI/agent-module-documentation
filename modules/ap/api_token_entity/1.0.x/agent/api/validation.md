<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Validating tokens

Two ways to authenticate a request: declaratively via a route requirement, or imperatively via the manager service.

## The manager service

Service id `api_token_entity.api_token.manager` → `Drupal\api_token_entity\ApiTokenManager` (`src/ApiTokenManager.php`), constructed with `@entity_type.manager`.

```php
public function checkApiToken(
  string $token_value,
  ?string $token_type = NULL,
  ?string $token_id = NULL,
): string|FALSE
```

Behaviour:

1. If `$token_type` is given, it loads the `api_token_entity_api_token_type` whose `name` equals `$token_type`; if none exists it returns `FALSE`.
2. It builds a property filter — `array_filter(['type' => <type id>, 'value' => md5($token_value), 'name' => $token_id], fn($v) => $v !== NULL)` — and calls `loadByProperties()` on the token storage. The presented value is `md5()`-hashed and matched against the stored hash; `$token_type`/`$token_id` narrow the match when supplied (each is dropped from the filter when `NULL`).
3. On a match it returns the token's `name` (the **Consumer ID**) as a string; otherwise `FALSE`.

```php
$consumer = \Drupal::service('api_token_entity.api_token.manager')
  ->checkApiToken($token_value, 'read_only', self::class);
if (empty($consumer)) {
  // invalid token
}
```

`ApiTokenManager::generateSecureApiTokenValue()` (static) returns a fresh `base64_encode(random_bytes(40))` value if you need to mint tokens in code.

## Route access check (`_api_token_type`)

Add the requirement to any route to gate it behind a valid token of a named type:

```yaml
mymodule.api.recipes:
  path: '/test/api/recipes'
  defaults:
    _controller: '\Drupal\mymodule\Controller\MyController::recipes'
  requirements:
    _api_token_type: 'recipes'
```

The requirement is handled by `ApiTokenTypeAccessCheck` (`src/Access/ApiTokenTypeAccessCheck.php`), registered as `access_check.api_token_entity.api_token_type` with `applies_to: _api_token_type`. `access()`:

1. Reads the `_api_token_type` requirement; empty → logs an error and `AccessResult::forbidden()`.
2. Reads the `Authorization` request header and requires the prefix `ApiKey ` (i.e. `Authorization: ApiKey <token>`); otherwise logs and forbids. The token is `substr($auth_header, 7)`.
3. Calls `$this->apiTokenManager->checkApiToken($api_token_value, $api_token_type)`. Empty result → forbidden; a returned consumer → `AccessResult::allowed()` (and a debug log line naming the consumer).

The value of `_api_token_type` is the token **type's `name`** (its machine-name identifier), e.g. `recipes` or `read_only`. Errors/acceptance are logged to the `api_token_entity.access` logger channel.

### Client request

```
GET /test/api/recipes HTTP/1.1
Authorization: ApiKey <plain token value copied at creation>
```

## Reference example

`tests/modules/api_token_entity_test/` (test-only, not shipped as a runtime submodule) wires two routes (`/test/api/recipes`, `/test/api/restaurants`) each guarded by `_api_token_type`, returning JSON from `TestController`. Use it as the canonical integration pattern.
