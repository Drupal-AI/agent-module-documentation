# Configuration

## Open the settings form

1. Log in as a user with the **`administer captcha protected pages`** permission
   (grant this only to trusted administrators).
2. Go to **Configuration → System → CAPTCHA Protected Page**, or navigate directly
   to `/admin/config/system/captcha-protected-page`.

## Settings

- **Protected paths** — Enter one path per line. Each entry can be an exact path or
  a `/prefix/*` wildcard that matches everything beneath it. Any visitor reaching a
  matching path is redirected to the verification page before they can continue.
- **Cookie expiration** — How long, in seconds, a successful verification lasts
  before the visitor is challenged again. The default is **86400** seconds (24
  hours).
- **Role restrictions** — The gate applies to **anonymous** users by default.
  Optionally, list additional authenticated roles that should also be required to
  verify. Authenticated users whose roles are not listed are not challenged.

## Save

Click **Save configuration**. The gate takes effect immediately for the paths you
listed.

## Important: what this protects, and what it does not

This is a **redirect-based deterrent**, not access control. The permissions on the
underlying pages are unchanged, so treat it as a way to slow bots and scrapers on
otherwise-permitted pages — not as a way to keep genuinely private content secret.

The public documentation notes two specific gaps in the current gate that you should
weigh before relying on it:

- The verification cookie's name is derived from an **unkeyed hash of the (known)
  path** and its value is a **fixed string**, so a client that knows the path can
  precompute and set the cookie to bypass the challenge.
- The gate is **skipped for any `POST` request**, so a POST straight to a protected
  path is not challenged.

For anything that must actually be restricted, put it behind real Drupal access
control (permissions, or a signed/session-bound verification token). Use this
module as a lightweight speed bump, not a lock.
