# Configuration

There are two admin forms, both requiring the **Administer site configuration**
permission and both writing to the `auth0.settings` config object.

## Basic settings

Go to **Configuration → Auth0** (`/admin/config/auth0`):

- **Auth0 domain** (`auth0_domain`) — your Auth0 tenant domain, e.g.
  `your-tenant.eu.auth0.com`.
- **Client ID** (`auth0_client_id`) — your Auth0 Application's Client ID.
- **Client secret key** (`auth0_client_secret_key`) — the **Key entity** that
  holds your client secret. This is the recommended way to supply the secret.
- **Client secret** (`auth0_client_secret`) — a place to paste the secret
  directly. Use this only if you are not using a Key entity; if you do, the module
  logs a warning suggesting you switch to the Key module.
- **Cookie secret key** (`auth0_cookie_secret_key`) — a Key entity holding the
  secret the SDK uses to encrypt its session cookie.
- **Cookie secret** (`auth0_cookie_secret`) — a direct fallback for the cookie
  secret, again with a warning if used.

The **redirect URI** is not stored — it is always
`https://your-site/auth0/callback`. Register that exact URL as an allowed callback
in your Auth0 Application. The requested scopes are fixed at `openid email
profile`.

> **Store secrets as Key entities.** The shipped configuration is empty — there
> are no default credentials. Keeping the client and cookie secrets in Key
> entities (backed by an environment variable or file) keeps them out of your
> exported configuration. See [Installation](../installation/index.md#prepare-your-secrets)
> for how to create the Key.

## Advanced settings

Go to `/admin/config/auth0/advanced`:

- **Require verified email** (`auth0_requires_verified_email`, default off) — only
  let users log in if their email is verified at Auth0.
- **Username claim** (`auth0_username_claim`, default `nickname`) — which Auth0
  claim becomes the Drupal username.
- **Claim mapping** (`auth0_claim_mapping`) — map Auth0 claims to Drupal profile
  fields, one `claim|field` pair per line (see syntax below).
- **Sync claim mapping** (`auth0_sync_claim_mapping`, default off) — re-apply the
  claim mapping on every login, not just at account creation.
- **Role mapping** (`auth0_role_mapping`) — map Auth0 roles to Drupal roles, one
  `auth0_role|drupal_role` pair per line.
- **Sync role mapping** (`auth0_sync_role_mapping`, default off) — re-apply the
  role mapping on every login.
- **Enable password reset** (`auth0_password_reset_enabled`, default off) — let a
  logged-in user request an Auth0 password-reset email for their own account (at
  `/auth0/password-reset`).
- **Password reset connection** (`auth0_password_reset_connection`, default
  `Username-Password-Authentication`) — the Auth0 database connection used for
  password resets.

### Mapping syntax

Both mappings are one pipe-delimited pair per line:

```
# Role mapping — Auth0 role name | Drupal role machine name
admin|administrator
editor|content_editor
```

```
# Claim mapping — Auth0 claim | Drupal field machine name
given_name|field_first_name
```

Role syncing only happens when both the role mapping is set **and** *Sync role
mapping* is on; the same applies to claim mapping and *Sync claim mapping*. Claim
mapping never overwrites protected fields (uid, init, name, uuid, pass, roles,
status).

## Setting values with Drush

```bash
ddev drush config:set auth0.settings auth0_domain your-tenant.eu.auth0.com -y
ddev drush config:set auth0.settings auth0_client_id XXXX -y
# reference a Key entity for the secret instead of a plaintext value:
ddev drush config:set auth0.settings auth0_client_secret_key auth0_client_secret -y
```

## How login works, and the legacy fallback

Once configured, `/user/login` redirects to Auth0, `/auth0/callback` handles the
return, and `/user/logout` logs the user out of both Drupal and Auth0. A native
Drupal login form stays available at **`/user/login/legacy`** as a break-glass
route — keep an administrator who can use it, in case Auth0 is ever
misconfigured or unreachable.
