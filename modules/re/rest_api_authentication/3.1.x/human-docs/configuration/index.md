# Configuration

All of the module's behavior is controlled from the miniOrange admin UI and stored
in a single configuration object, `rest_api_authentication.settings`. The important
thing to understand is that **installing the module protects nothing** — you must
turn on the master switch and choose an authentication method before any endpoint
is secured.

## A note on credentials

The API token and any Basic Auth credentials are secrets. Keep the raw values in
environment variables and out of committed, exported configuration. Rotate the
token if it is ever exposed, and use the `/rest_api/revoke` endpoint to invalidate
tokens you no longer trust.

## Open the settings forms

All of these forms require the core **Administer site configuration** permission.

| Form | Path | What it controls |
|------|------|------------------|
| **API Authentication** (main) | `/admin/config/people/rest_api_authentication/auth_settings` | the master switch, method, and token |
| **Advanced settings** | `.../advanced-settings` | additional options |
| **Headless SSO** | `.../headless-sso` | headless single sign-on (premium) |
| **Audit logs** | `.../audit-logs` | a record of every authentication attempt |
| **Upgrade plans** | `.../upgrade-plans` | premium miniOrange plans |

## Step 1 — Turn protection on

The **master switch** is the `enable_authentication` setting. Until it is on, the
authentication provider stays out of the way and your API is served as before. When
you turn it on, the provider begins claiming requests to `/jsonapi/…` and
`?_format=…` endpoints (the JSON:API admin page and `/user/login` are always
excluded). You can toggle it from the main settings form, or from the command line:

```bash
drush cget rest_api_authentication.settings enable_authentication
```

## Step 2 — Choose an authentication method

Each request is matched to an **application**, and each application declares which
method it uses. The method ids are:

- **`0` Basic Auth** — the caller sends standard HTTP Basic credentials
  (`username:password`).
- **`1` API key** — the caller sends an `api-key` header (a base64 of
  `username:token`) or an `Authorization: Basic` header; the token is compared
  against the configured value.
- **`2` OAuth** — premium.
- **`3` JWT** — premium.
- **`4` External OAuth** — premium.

In the free version, use **API key** or **Basic Auth**. Requests select their
application via an `auth-method` request header carrying the application id; if no
header is sent, the **default application** (`default_application_id`) is used, so
set one if your clients cannot add that header.

## Step 3 — Set the token (API-key method)

For the API-key method, set the expected token in the `api_token` setting from the
main form. Your API clients must then present that token on every request. The
matching validator accepts either an `api-key` header or an `Authorization: Basic`
header carrying `username:token`.

## Reviewing the audit logs

Every authentication attempt — success or failure — is recorded to a database table
by the module's logger and shown on the **Audit logs** form. Use it to spot
misconfigured clients or unauthorized probing. You can purge old entries from the
**Delete logs** confirmation page linked off that form.

## Revoking a token

The public endpoint `/rest_api/revoke` revokes an issued token. Although the route
itself is publicly reachable, the controller validates Basic Auth credentials and
the HTTP method before doing anything, so a caller must prove who they are to revoke
a token.

## What is and isn't protected

With protection on, only API traffic is affected: requests whose URL contains
`/jsonapi/` or `?_format=`. Normal HTML page requests are never touched, the
JSON:API admin configuration page is excluded, and `/user/login` always passes
through so clients can still obtain a session. To keep protected responses from
being served stale, the module also excludes authenticated API responses from the
page cache.
