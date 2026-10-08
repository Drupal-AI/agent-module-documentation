# Configuration

Setting up Redirect After Logout is two steps: fill in the settings form, then
grant the permission to the roles that should be redirected. Both are needed —
without the permission, no one is redirected even if a destination is set.

## Step 1 — The settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Redirect After Logout**, or navigate
   directly to `/admin/config/system/redirect_after_logout`.

Fill in the fields:

- **Destination** *(required)* — where to send the user after they log out. You
  can enter:
  - `<front>` — the site's front page.
  - an **internal path** with a leading slash, e.g. `/goodbye` or `/node/1`.
  - a **full external URL**, e.g. `https://example.com/portal` — redirecting
    off‑site is a supported feature.
  - a **token**, e.g. `[current-page:url]`, to build the destination dynamically
    (requires the Token module for the token browser, though tokens are replaced
    regardless).

  When you save, the module validates the value: it replaces any tokens, strips
  dangerous protocols, requires internal paths to start with `/`, and checks that
  the path is valid and accessible. An invalid destination blocks the save.

- **Message** *(optional)* — a one‑time message shown to the user after logout.
  Tokens are allowed, and newlines are converted to line breaks. Leave it blank
  for no message.

- **Message type** — how the message is styled: **Status** (the default green
  notice), **Warning** (amber), or **Error** (red). Only relevant if you set a
  message.

Click **Save configuration**.

> **Note on the message and external redirects.** The one‑time message is shown
> after the redirect, on your own site, to the now‑anonymous visitor. If the
> destination is an **external** URL, the visitor leaves your site, so a message
> can only appear when the destination is local.

## Step 2 — Grant the permission (who gets redirected)

The redirect only fires for users who hold the **Redirect user after logout**
permission. This is what lets you target specific roles.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Redirect user after logout** (provided by this module).
3. Tick it for each role that should be redirected on logout, and **Save
   permissions**.

For example, grant it to the *Authenticated user* role to redirect everyone, or
to a specific role like *Member* to redirect only them — and leave it off for
editors/admins if you'd rather they land on the normal logout page.

## How it behaves at logout

When a user with the permission logs out, the module replaces the normal logout
redirect with your configured destination, resolving `<front>`, external URLs, and
internal paths correctly. If you set a message and the destination is local, the
message is shown once to the logged‑out visitor. The redirect is **not** applied
during a Masquerade session, so unmasquerading is never hijacked.

## Setting values without the UI

The settings live in the `redirect_after_logout.settings` config object, so you
can script or override them — for example via Drush
(`drush config:set redirect_after_logout.settings destination /goodbye -y`) or a
per‑environment override in `settings.php`
(`$config['redirect_after_logout.settings']['destination'] = '…';`).
