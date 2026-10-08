# Anonymous CSRF tokens — wiring & the service

The 2.x/3.x design does **not** protect anything automatically. Two steps per protected route:
add the access requirement, and generate the matching token where you build the link/form.

## 1. Require the token on a route

In your module's `*.routing.yml`:

```yaml
my_module.confirm:
  path: '/my/confirm/{id}'
  defaults:
    _controller: '\Drupal\my_module\Controller\MyController::confirm'
  requirements:
    _anonymous_csrf_token: 'TRUE'
```

`_anonymous_csrf_token` is served by `access_check.anonymous_token.csrf`
(`AnonymousCsrfAccessCheck`, subclasses core `CsrfAccessCheck`, `needs_incoming_request: TRUE`).
Like core CSRF checks it verifies a `token` value against the route — pass it as the `?token=`
query argument. The difference from core's `_csrf_token` is only that the token generator is the
anonymous-aware one, so the check succeeds for anonymous users.

## 2. Generate the token

```php
/** @var \Drupal\anonymous_token\Access\AnonymousCsrfTokenGenerator $csrf */
$csrf = \Drupal::service('anonymous_token.csrf_token');
$token = $csrf->get($value);   // $value is the string the route validates against
// e.g. build the URL with ['query' => ['token' => $token]]
```

`get()` first ensures a session exists for anonymous users — if no session is started it writes
`anon_session_id` (a `Crypt::randomBytesBase64()` value) so the session (and thus the CSRF seed)
persists across requests — then delegates to core `CsrfTokenGenerator::get()`. The token is an
HMAC over the site's private key plus the per-session seed; it is not guessable and is scoped to
the visitor's session.

## Validation & single-use

`validate($token, $value)` delegates to core. When `force_single_use` is on **and** the current
user is anonymous **and** validation succeeds, it calls `$this->sessionMetadata->stampNew()`,
which rotates the session's CSRF seed so the same token cannot be replayed. With single-use off,
the token stays valid for the life of the session seed (core default behaviour).

## Service / class map

| Id | Class | Role |
|---|---|---|
| `anonymous_token.csrf_token` | `AnonymousCsrfTokenGenerator` | `get()`/`validate()`, anonymous-session persistence + single-use. |
| `access_check.anonymous_token.csrf` | `AnonymousCsrfAccessCheck` | Route access checker for `_anonymous_csrf_token`. |

Constructor args of the generator: `@private_key`, `@session_manager.metadata_bag`, `@session`,
`@config.factory`, `@current_user`.
