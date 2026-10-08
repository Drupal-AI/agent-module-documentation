# Configuration

Anonymous Token has a very small configuration surface: **one setting**, **one
permission**, and a two‑step wiring you do in code for each route you want to protect.

## The settings form

Go to **Configuration → System → Anonymous CSRF Token**
(`/admin/config/system/anonymous-csrf-token`). You need the **Administer anonymous
csrf token** permission. The form has a single option:

- **Force single use** (`force_single_use`, default **off**) — when on, a token that
  an anonymous user successfully validates rotates the session's CSRF seed, so the
  same token cannot be replayed a second time. Leave it off and a token stays valid
  for the life of the session seed (core's default behavior).

You can also set it from the command line instead of the UI:

```bash
drush config:set anonymous_token.settings force_single_use true -y
```

## The permission

| Permission | Gates |
|---|---|
| **Administer anonymous csrf token** | The settings form only. |

It's the only permission the module adds, and it just controls that one hardening
toggle.

## Wiring a route (this is the part that actually protects something)

Because nothing is automatic, protecting an anonymous‑facing route takes two steps.

**1. Require the token on the route** — in your module's `*.routing.yml`:

```yaml
my_module.confirm:
  path: '/my/confirm/{id}'
  defaults:
    _controller: '\Drupal\my_module\Controller\MyController::confirm'
  requirements:
    _anonymous_csrf_token: 'TRUE'
```

The `_anonymous_csrf_token` requirement works just like core's `_csrf_token`, except
it uses the anonymous‑aware token generator, so the check succeeds for anonymous
users. It reads the token from the `?token=` query argument.

**2. Generate the matching token** where you build the link or form:

```php
/** @var \Drupal\anonymous_token\Access\AnonymousCsrfTokenGenerator $csrf */
$csrf = \Drupal::service('anonymous_token.csrf_token');
$token = $csrf->get($value);   // $value is the string the route validates against
// e.g. build the URL with ['query' => ['token' => $token]]
```

Generating the token is also what triggers the persistent anonymous session (the
module writes a random session id if none is started yet) so the CSRF seed survives
across requests. The token is an HMAC over the site private key plus the per‑session
seed — core crypto, not guessable. See the sibling
[`agent/api/csrf.md`](../agent/api/csrf.md) for the full service/class map and
validation details.
