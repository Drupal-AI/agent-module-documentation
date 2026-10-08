# Configuration

Login Register Path has a single, simple settings form where you set the custom
paths for the login and register pages.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Login Register Path**, or navigate
   directly to `/admin/config/user-interface/login-register-path`.

## Set the custom paths

Enter the path(s) you want the core login and register forms to be served at — for
example `/signin` in place of `/user/login`, or `/join` in place of
`/user/register`. The forms behave exactly as before at their new addresses; only
the URL changes.

## Save

Click **Save configuration**, then visit your new path to confirm the form appears
there.

## Keep in mind

- This is a **path change, not an authentication change** — Drupal's normal login
  and registration logic and access rules still apply at the new URL.
- A custom path is **not a security measure**. The default paths may remain
  reachable or discoverable, so don't treat renaming the login page as a way to
  hide or protect it. Use it for branding and tidy URLs.
