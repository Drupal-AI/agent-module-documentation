# Configuration

Protected Pages has two parts: a **global settings form** (password mode, unlock
duration, and all the wording on the prompt) and the **list of protected paths**
you add one at a time. This page covers both.

## Open the settings form

1. Log in as a user with the **Administer protected pages configuration**
   permission.
2. Go to **Configuration → System → Protected Pages → Settings**, or navigate
   directly to `/admin/config/system/protected_pages/settings`.

Settings are stored in the `protected_pages.settings` config object. Saving the
form flushes all caches so pages start (or stop) being protected immediately.

## Password mode

The core choice is **how a page can be unlocked**
(`password.per_page_or_global`):

- **Per page or global** *(default)* — either the page's own per-page password or
  the site-wide global password unlocks the page.
- **Per page only** — only the password you set on the individual page works.
- **Global only** — a single global password unlocks every protected page.

If you use a global password, set it in the **Global password** field on this same
form. It is hashed before being stored.

## Session expire time

- **Session Expire Time** (`password.protected_pages_session_expire_time`,
  default **0**) — how many minutes an unlock lasts after a correct password.
  `0` means the unlock lasts for the whole session (no expiry). Set a number to
  force visitors to re-enter the password after that many minutes.

## Prompt page wording

Everything the visitor sees on the password prompt is editable here:

- **Title** (`others.protected_pages_title`) — the prompt page title.
- **Description** (`others.protected_pages_description`) — introductory text
  (HTML allowed).
- **Fieldset legend**, **Password label**, and **Submit button text** — the
  labels around the password field and button.
- **Incorrect password message** — the error shown after a wrong guess.

## Invitation email text

Protected Pages can email a protected page's URL to users. The default **subject**
and **body** for that email are set here (`email.subject`, `email.body`); the body
supports the `[protected-page-url]` and `[site-name]` tokens. You send the actual
emails from a page's row in the protected-pages list.

## Add a protected path

Go to **Configuration → System → Protected Pages** and click **Add protected
page** (`/admin/config/system/protected_pages/add`). Fill in:

- **Relative path** — must start with `/`, e.g. `/node/5` or `/new-events`. Use
  `*` wildcards to match many pages: `/new-events/*` protects everything under
  that path, and `/*` protects the whole site. A real (non-wildcard) path is
  validated, and a path already protected is rejected.
- **Admin Title** — a label for your reference only; visitors never see it.
- **Password** — the per-page password (hashed and stored). This is what "per
  page" password modes use.

Saving flushes caches so a page that was already cached before you protected it
isn't served stale. Note that protected pages are stored as plain database rows,
**not** configuration, so they do not move between environments with
`drush config:export`.

Each row in the list also offers **Edit**, **Delete**, and **Send email** (to
notify users of the page and its URL).

## Brute-force protection

The password prompt throttles wrong guesses by IP address using Drupal's core
flood control. By default it allows **5** attempts within a **900-second**
(15-minute) window; after that the visitor sees "Too many failed login attempts
from your IP address," and a successful login clears the counter. These limits
are not on the settings form — override them if needed with:

```bash
drush cset protected_pages.settings flood_control.limit 10
drush cset protected_pages.settings flood_control.window 600
```

## Save

Click **Save configuration** on the settings form. Because saving flushes caches,
your changes — including newly protected or unprotected paths — take effect right
away.
