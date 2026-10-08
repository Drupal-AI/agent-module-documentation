# Configuration

## Open the settings form

1. Log in as a user with the **Administer access_token_auth configuration**
   permission.
2. Go to **Configuration → Web services → Access Token Authentication**, or
   navigate directly to `/admin/config/services/access-token-auth`.

## Permissions

The module adds several restricted permissions — grant them carefully, because
they govern who can mint and use API credentials:

- **Administer access_token_auth configuration** — configure the module.
- **Allow generate access_token_auth** — generate tokens.
- **Access own access_token_auth list** — see one's own tokens.
- **Invalidate own access_token_auth** / **Invalidate any access_token_auth** —
  revoke one's own, or anyone's, tokens.
- **Access any access_token_auth** — see and manage tokens across all users
  (an administrative capability).

## Settings

- **Authentication mode** — choose **Time based** (the token is valid until it
  expires) or **One time** (the token is rejected after its first use).
- **Token lifetime (TTL)** — for time-based mode, how long a token stays valid,
  configurable between **30 and 1800 seconds**. Keep this short.
- **Single token** — when enabled, generating a token reuses an existing valid one
  for the user instead of minting a new one each time.
- **Stub user** — optionally nominate one account so that *every* token
  authenticates as that single service account, rather than as each token's own
  owner. Use this when you want a shared machine identity.
- **Delete expired tokens** — when enabled, cron cleans up expired and used tokens
  from the database.

## Generating and using a token

1. With the **Allow generate access_token_auth** permission, generate a token from
   the settings form.
2. **Copy it immediately** — afterwards only the last four characters are shown.
3. Send it on API requests in the header:

   ```
   X-ACCESS-AUTH-TOKEN: <token>
   ```

   A query parameter of the same name also works, but avoid it — tokens then leak
   into access logs and referrer headers.

Each successful validation marks the token as used and logs the event. In one-time
mode the token is rejected after the first use; in time-based mode it is rejected
once it expires.

## Managing tokens

- Users list their valid tokens at
  `/admin/config/services/access-token-auth/list`.
- Invalidate a token through its confirm form; a full invalidation also back-dates
  the expiry so the token cannot be used again.
- A user only sees their own tokens unless they hold **Access any
  access_token_auth**.

## Security reminders

- **Serve over HTTPS** so tokens cannot be sniffed in transit.
- **Prefer the header** over the query parameter.
- **Keep TTLs short**, and prefer one-time mode for the most sensitive use.
