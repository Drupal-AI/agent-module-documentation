# Configuration

REST API Access Token has one settings form that controls how login works, whether
requests are signature-checked, whether responses are cached, and how long tokens
and cache entries live.

## Open the settings form

1. Log in as a user with the **Administer rest api access token** permission.
2. Go to **Configuration → System → REST API Access Token**
   (`/admin/config/system/rest_api_access_token`).

Because the module ships **no default configuration**, every option starts unset
until you save this form — which is why signature verification and caching are off
and the token lifetime is infinite out of the box. Saving the form at least once is
part of setup.

## Login settings

- **Login via API by user name** (`login_by_name`) — allow the login endpoint to
  match the submitted `login` value against usernames.
- **Login via API by user mail** (`login_by_mail`) — allow it to match against
  email addresses.

You must enable at least one of these (the form requires it). Enable both to let
clients log in with either their username or their email.

## Signature verification

- **Enable signature verification** (`signature_verification`) — when on, every
  authenticated request must also carry a valid **`X-AUTH-SIGNATURE`** header,
  computed by the client from the request details and the **secret** returned at
  login. This means a stolen public token alone is no longer enough to make
  requests, so it is strongly recommended for anything sensitive. **Off by
  default.**

The signature is a SHA-256 hash of the token, request ID, path, request body, and
secret; the secret itself is never sent on normal requests.

## Response cache

- **Enable cache endpoints by REQUEST-ID** (`cache_endpoints`) — when on, the
  module caches full responses per user and per request, keyed by a **`REQUEST-ID`**
  header the client must send. This speeds up repeated reads. **Off by default.**
- **Lifetime of cache endpoints (seconds)** (`cache_endpoints_lifetime`) — how long
  a cached response lives. `0` means permanent, and `-1` disables caching. Keep
  this short for sensitive endpoints.

## Token lifetime

- **Lifetime of auth token (hours)** (`token_lifetime_hours`) — Drupal's cron
  prunes tokens whose last activity is older than this many hours. `0` means tokens
  never expire.

**Set a finite value for production.** With the default of `0`, a leaked token stays
valid until an explicit logout, so a finite lifetime limits the window of a
compromised token.

## Save

Click **Save configuration**. Changes take effect immediately for new requests.

## Setting values in code

You can also configure the module programmatically, for example in a deployment
script:

```php
\Drupal::configFactory()->getEditable('rest_api_access_token.config')
  ->set('login_by_name', 1)
  ->set('signature_verification', 1)
  ->set('token_lifetime_hours', 24)
  ->save();
```
