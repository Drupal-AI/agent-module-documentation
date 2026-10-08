# Configuration

The only thing you configure in the admin UI is **which authentication providers are
accepted on the `/jsonrpc` endpoint**. Everything else — the methods, their parameters, and
their access rules — lives in code.

## Open the settings form

1. Log in as a user with the **Administer JSON-RPC** (`administer jsonrpc`) permission.
2. Go to **Configuration → System → JSON-RPC** (`/admin/config/system/jsonrpc`).

## Allowed authentication providers

The form is a set of checkboxes, one per authentication method. Tick the providers your
callers will use:

- **Basic auth** *(on by default)* — HTTP Basic authentication. Requires core's `basic_auth`
  module.
- **OAuth2** *(on by default)* — token-based OAuth2 authentication. Requires an OAuth2
  provider such as the Simple OAuth module.
- **Cookie** *(off by default)* — Drupal's ordinary session cookie. Turning this on makes the
  endpoint reachable from a logged-in browser session.
- **JWT** *(off by default)* — JSON Web Token authentication. Requires the JWT module.

Ticking a provider whose module is not installed simply has no effect — the provider is not
available until you enable its module.

## Saving and applying

Click **Save configuration**. The change rewrites the `/jsonrpc` route's authentication
options, which takes effect after the router is rebuilt. If the new setting doesn't seem to
apply, rebuild caches:

```bash
ddev drush cr
```

## Don't forget the permissions

Configuring auth providers is only half the picture. Access is also governed by two
permissions:

| Permission | Gates |
|---|---|
| **Use JSON-RPC services** (`use jsonrpc services`) | Reaching the `/jsonrpc` endpoint at all, and the discovery routes. It does **not** by itself authorize any specific method — each method also checks its own permissions. On a decoupled site this is usually granted to an API/service account rather than to end users. |
| **Administer JSON-RPC** (`administer jsonrpc`) | This settings form. |

Because `use jsonrpc services` is the floor for every method, and a method written with no
explicit access permissions is callable by anyone who holds it, decide carefully which roles
receive it.
