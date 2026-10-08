# Configuration

Logout Redirect has a single setting: the path a logged‑out visitor is sent to if
they press the browser's Back button.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission.
2. Go to **Configuration → System → Logout Redirect Configuration**, or navigate
   directly to `/admin/config/logout/redirect/settings`.

## Redirect path

Enter the path (or URL) to redirect logged‑out visitors to when they navigate
Back into a cached authenticated page. Some pointers:

- Leave it blank to use the default, **`/user/login`**.
- Enter a custom login path if your site uses one — for example `/login` for an
  SSO login page, or a branded login route.
- The value is trimmed on save, and if you accidentally enter a comma‑separated
  list only the part before the first comma is kept, so enter a single path.

Because the target is set here by an administrator and never read from the
request URL, this is not an open redirect.

## Save

Click **Save configuration**. The new target takes effect immediately — the
attached JavaScript picks it up on the next page load.

> **Remember:** this is a client‑side, JavaScript‑based guard. Keep it as one
> layer of defence alongside proper `Cache-Control: no-store` headers on
> authenticated responses, not as your only protection.
