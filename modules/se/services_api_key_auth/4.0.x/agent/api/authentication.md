# API key authentication provider

The module registers one Symfony/Drupal authentication provider and no other public API.

## The service

`services_api_key_auth.services.yml`:

| | |
|---|---|
| Service id | `services_api_key_auth.authentication.api_key_auth` |
| Class | `Drupal\services_api_key_auth\Authentication\Provider\ApiKeyAuth` |
| Arguments | `@config.factory`, `@entity_type.manager`, `@current_route_match` |
| Tag | `authentication_provider` |
| `provider_id` | `api_key_auth` |
| `priority` | `100` |
| `global` | *not set* → **FALSE** |

Implements `Drupal\Core\Authentication\AuthenticationProviderInterface`. (An older service alias
`authentication.api_key_auth` was renamed to the id above; `hook_update_10002` just rebuilds the
container.)

## Runtime flow

`applies(Request $request)` returns `TRUE` when `getKey($request) !== FALSE`.

`getKey(Request $request)` resolves the presented key, in this order:
1. If the current route name contains `entity.api_key`, return `FALSE` (the module's own key
   add/edit/delete/list routes are exempt, so a key being edited cannot authenticate against its
   own admin form).
2. Read config `services_api_key_auth.settings`. If `api_key_request_header_name` is non-empty and
   the request has that **header** with a non-empty value, return it.
3. Else if `api_key_post_parameter_name` is non-empty and that **POST body** parameter is non-empty,
   return it.
4. Else if `api_key_get_parameter_name` is non-empty and that **query string** parameter is
   non-empty, return it.
5. Otherwise return `FALSE`.

`authenticate(Request $request)`:
```php
$api_key_entities = $this->entityTypeManager->getStorage('api_key')
  ->loadByProperties(['key' => $this->getKey($request)]);   // exact storage lookup
foreach ($api_key_entities as $key_item) {
  if ($this->getKey($request) == $key_item->key) {          // matched entity
    $accounts = $this->entityTypeManager->getStorage('user')
      ->loadByProperties(['uuid' => $key_item->user_uuid]); // resolve the bound user
    $account = reset($accounts);
    if (isset($account)) {
      return $account;                                       // request now runs as this user
    }
    break;
  }
}
return NULL;                                                 // no key / no match / no user → deny
```
An empty or absent key never reaches this method (`applies()` is `FALSE`), and a non-matching key
returns `NULL`, i.e. authentication fails and the request stays anonymous.

`handleException(ExceptionEvent $event)` rewrites a core `AccessDeniedHttpException` into an
`UnauthorizedHttpException('Invalid consumer origin.')` (401 instead of 403) for its requests.

`cleanup()` is a no-op.

## Enabling the provider on an endpoint

The provider is **not global**, so core keeps its authenticated account only on routes that list
`api_key_auth` in the route `_auth` option (Drupal core `AuthenticationManager::defaultFilter()`
resets everything else back to anonymous after routing). Three ways to opt in:

- **JSON:API** — automatic. `jsonapi`'s route builder sets `_auth` to *every* registered provider
  id (`Drupal\jsonapi\Routing\Routes`), so `api_key_auth` is accepted on all JSON:API routes with no
  extra config once this module is enabled.
- **Core REST resource** — add `api_key_auth` to the resource's authentication list. In the
  `rest.resource.*` config entity (or the REST UI module):
  ```yaml
  # rest.resource.entity.node.yml (excerpt)
  authentication:
    - api_key_auth
    - cookie
  ```
  Core `ResourceRoutes` copies that list into the route `_auth` option.
- **A custom route** — set the option directly:
  ```yaml
  my_module.my_api:
    path: '/my/api'
    defaults: { _controller: '...' }
    requirements: { _permission: 'access content' }
    options:
      _auth: ['api_key_auth']
  ```

## Sending an authenticated request

With defaults (header named `api_key`):
```
GET /jsonapi/node/article HTTP/1.1
api_key: 1a2b3c...   # the key value stored on an api_key entity
```
If a POST or GET parameter name is configured instead, send the key as that body field or query
argument (e.g. `?api_key=1a2b3c...`). The request executes with the permissions of the user bound to
that key. See [configure/settings.md](../configure/settings.md) for choosing the transport and
[configure/api-keys.md](../configure/api-keys.md) for creating keys.
