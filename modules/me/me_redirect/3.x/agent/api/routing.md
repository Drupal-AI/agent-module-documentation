# Route, controller and path processor (API)

The whole module is one route, one controller method, and one inbound path-processor service. There
is no PHP-callable service to reuse — this file documents the machine names and the resolution
mechanism an agent needs to reason about `/me/*` URLs.

## Route — `me_redirect.me`

`me_redirect.routing.yml`:

```yaml
me_redirect.me:
  path: /me/{user_path}
  defaults:
    _controller: '\Drupal\me_redirect\Controller\MeController::me'
    user_path: ''
  requirements:
    _permission: 'access content'
```

- `{user_path}` defaults to `''`, so bare `/me` matches too (destination `/user/{uid}`).
- The only route access check is the core `access content` permission. There is no CSRF token and
  no custom access service; access is finalized in the controller (see below).

## Controller — `MeController::me($user_path)`

`src/Controller/MeController.php` (extends `ControllerBase`):

```php
public function me($user_path) {
  $user_id = \Drupal::currentUser()->id();
  if (!empty($user_id)) {                 // logged in (anon uid 0 is empty)
    $uri = '/user/' . $user_id;
    if (!empty($user_path)) {
      $user_path = str_replace(':', '/', $user_path);   // colons back to slashes
      $uri .= '/' . $user_path;
    }
    return new RedirectResponse($uri, 302);
  }
  throw new AccessDeniedHttpException();   // anonymous -> 403
}
```

- The uid comes from `\Drupal::currentUser()->id()` — the **session** user, never a request
  parameter. The destination is always literally prefixed `/user/{uid}/`, so it is same-origin and
  always the caller's own account. There is no `?destination=` handling and no request-supplied uid.
- Anonymous callers (uid `0` → `empty()`) get `AccessDeniedHttpException` (HTTP 403), even though the
  route's `access content` permission is granted to anonymous by default.
- The redirect is a `302` (temporary) by design so downstream behavior can change without permanent
  caching.

## Inbound path processor — `me_redirect.path_processor`

`me_redirect.services.yml` registers `Drupal\me_redirect\PathProcessor\MePathProcessor`
(`InboundPathProcessorInterface`) tagged `path_processor_inbound` with **priority 250**:

```php
public function processInbound($path, Request $request) {
  if (strpos($path, '/me/') === 0) {
    $names = preg_replace('|^\/me\/|', '', $path);   // strip leading /me/
    $names = str_replace('/', ':', $names);          // slashes -> colons
    $path = "/me/$names";
  }
  return $path;
}
```

A single Drupal route parameter cannot span `/`, so this collapses the sub-path into a colon-joined
token before routing (`/me/edit/foo` → `/me/edit:foo`); the controller reverses it when building the
target. Only paths beginning exactly with `/me/` are touched.

## Resolution examples (runtime-verified, Drupal 11.x, v3.0.0)

| Request (authenticated uid 1) | Route `user_path` | Redirect `Location` |
|---|---|---|
| `/me` | `''` | `/user/1` |
| `/me/edit` | `edit` | `/user/1/edit` |
| `/me/edit/foo` | `edit:foo` | `/user/1/edit/foo` |

Anonymous `/me` and `/me/edit` both return HTTP `403`.
