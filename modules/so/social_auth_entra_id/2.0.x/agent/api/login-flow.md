# Login flow, routes & claim→user mapping

The module implements the OAuth 2.0 Authorization Code flow directly against Microsoft
`login.microsoftonline.com` (via core `http_client`); it does not use the Social API / league
oauth2-client. Everything lives in `SocialAuthEntraIdController`.

## Routes (`social_auth_entra_id.routing.yml`)

| Route | Path | Access | Controller method |
|---|---|---|---|
| `social_auth_entra_id.redirect` | `/user/login/entra-id` | `_access: TRUE`, `no_cache: TRUE` | `redirectToMicrosoft()` |
| `social_auth_entra_id.callback` | `/user/login/entra-id/callback` | `_access: TRUE`, `no_cache: TRUE` | `handleMicrosoftCallback()` |

To start a login from anywhere, link users to route `social_auth_entra_id.redirect`
(`Url::fromRoute('social_auth_entra_id.redirect')`) — that is what the login block does.

## `redirectToMicrosoft()`

1. Reads `client_id`, `tenant_id`, `account_type` from config. `endpoint = account_type === 'organization' ? tenant_id : account_type` (i.e. the literal `common`/`consumers` for those types).
2. If `client_id` empty, or `account_type === 'organization'` with empty `tenant_id`, sets an error and redirects to `user.login`.
3. Generates `state = bin2hex(random_bytes(32))` and `nonce = bin2hex(random_bytes(32))`, stored in `$_SESSION['entra_id_oauth_state']` / `['entra_id_oauth_nonce']`. Stores the absolute callback URL (default language) in `$_SESSION['entra_id_redirect_uri']` and the endpoint in `$_SESSION['entra_id_oauth_endpoint']`.
4. Returns a `TrustedRedirectResponse` (no-store) to
   `https://login.microsoftonline.com/{endpoint}/oauth2/v2.0/authorize` with `client_id`,
   `response_type=code`, `redirect_uri`, `scope=openid profile email User.Read`, `state`, `nonce`.

## `handleMicrosoftCallback(Request)`

1. Reads `code` and `state` from the query. Rejects when `$_SESSION['entra_id_oauth_state']` is empty or `state !== session state` (logs a warning, redirects to `user.login`). Clears the state on success (one-time use).
2. POSTs to `https://login.microsoftonline.com/{endpoint}/oauth2/v2.0/token` with `form_params` `client_id`, `client_secret`, `code`, `redirect_uri`, `grant_type=authorization_code`. Requires both `access_token` and `id_token` in the response.
3. Splits the `id_token` JWT into 3 parts and base64-decodes the payload. Validates claims: `aud === client_id`; issuer (`organization` → exact `https://login.microsoftonline.com/{tenant_id}/v2.0`, else regex `https://login.microsoftonline.com/{anything}/v2.0`); `exp >= time()`; `nonce === session nonce` (then clears nonce).
4. Picks the email from claims in priority `email` → `preferred_username` → `unique_name`; lowercases/trims it and requires `FILTER_VALIDATE_EMAIL`.
5. Calls Microsoft Graph `GET https://graph.microsoft.com/v1.0/me` with the bearer access token, only for `displayName` (used to seed the username). A Graph failure is logged at notice level and does not block login.

### Claim → user mapping

- **Domain allowlist**: if `allowed_domains` is non-empty and the email's domain is not in it → error, redirect to `<front>`.
- **Existing user** = `user_load_by_mail($email)`. If found:
  - blocked account → refuse (logged with IP);
  - `block_user_1` and uid 1 → refuse;
  - `block_admin_role` and user has role `administrator` → refuse;
  - otherwise `user_login_finalize($existing_user)`.
- **No existing user** and `login_behavior === 'register_and_login'`: username seeded from Graph `displayName` (fallback = email local-part), sanitized to `[\x80-\xF7 a-z0-9@_.'-]`, made unique by appending `_1`, `_2`, … (`user_load_by_name` loop); `User::create(['name', 'mail', 'status' => 1])`, `save()`, `user_login_finalize()`.
- **No existing user** and `login_only`: generic "Unable to log in" error (account-enumeration-safe), redirect to `<front>`.
- All error/finalize responses are `no-store`. On any thrown exception the handler logs the detail, shows a generic error, and `sleep(2)` before redirecting to `<front>`.

There is no persistent mapping table: identity is re-resolved by email claim on every login. No `oid`/`sub`/`tid` is stored against the Drupal account.
