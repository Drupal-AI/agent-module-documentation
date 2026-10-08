# Configure protected pages, passwords & the prompt

## Admin routes (all `/admin/config/system/protected_pages/...`)

All require the `administer protected pages configuration` permission.

| Route | Path | Purpose |
|---|---|---|
| `protected_pages_list` | `/` | List protected pages (paginated, 20/page) |
| `protected_pages_add` | `/add` | Add a protected path + password |
| `protected_pages_edit` | `/{pid}/edit` | Edit a protected page |
| `protected_pages_delete` | `/{pid}/delete` | Delete a protected page |
| `protected_pages_send_email` | `/{pid}/send_email` | Email the page URL to users |
| `protected_pages_settings` | `/settings` | Global settings form (the `configure` route) |
| `protected_pages_login_page` | `/protected-page` (top level) | The visitor password prompt |

## Add a protected path + password

At `/admin/config/system/protected_pages/add` (`ProtectedPagesAddForm`):

- **Relative path** — must start with `/`, e.g. `/node/5`, `/new-events`. Use `*` wildcards
  to match multiple pages: `/new-events/*`, or `/*` for the whole site. Non-wildcard paths
  are validated as real paths; a path (or its alias) already protected is rejected.
- **Admin Title** — reference label only, not shown to visitors.
- **Password** (`password_confirm`) — hashed (core `password` service) and stored in the
  `protected_pages` table row. This is the page's per-page password.

Protected pages are plain DB rows (no config entity), so they do **not** export with
`drush config:export`. See [api/protected_pages.md](../api/protected_pages.md) for the storage
service.

## Global settings — `protected_pages.settings` config object

Edit at `/admin/config/system/protected_pages/settings` (`ProtectedPagesSettingForm`) or with
`drush cget/cset protected_pages.settings <key>`.

| Key | Default | Meaning |
|---|---|---|
| `password.per_page_or_global` | `per_page_or_global` | Password mode (see below) |
| `password.protected_pages_global_password` | (unset) | Hashed site-wide global password |
| `password.protected_pages_session_expire_time` | `0` | Minutes an unlock lasts; `0` = unlimited |
| `email.subject` | "Please visit this new page" | Invitation email subject |
| `email.body` | (template) | Email body; tokens `[protected-page-url]`, `[site-name]` |
| `others.protected_pages_title` | "Protected Page -- Enter password" | Prompt page title |
| `others.protected_pages_description` | (text) | Prompt description (HTML allowed) |
| `others.protected_pages_password_fieldset_legend` | "Enter password" | Fieldset legend |
| `others.protected_pages_password_label` | "Enter password" | Password field label |
| `others.protected_pages_submit_button_text` | "Authenticate" | Submit button text |
| `others.protected_pages_incorrect_password_msg` | (text) | Error on wrong password |

**Password mode** (`password.per_page_or_global`):
- `per_page_password` — only the per-page password (from the DB row) is accepted.
- `per_page_or_global` — the per-page password **or** the global password unlocks the page (default).
- `only_global` — only the global password is accepted for every protected page.

The global password is set via the settings form's password field; it is hashed with the core
`password` service before being written to `password.protected_pages_global_password`.

## Session length & the unlock

On a correct password, the login form records `$_SESSION['_protected_page']['passwords'][$pid]`
with a request time, and (if `protected_pages_session_expire_time` > 0) an expiry
`now + N minutes`. While the unlock is present and unexpired, the subscriber lets the page
through; once it expires the visitor is prompted again.

## Flood control (brute-force protection)

The login form throttles wrong guesses by IP using the core `flood` service with keys read
from config (with fallbacks if unset): `flood_control.limit` (default **5**) and
`flood_control.window` seconds (default **900**). After too many failures the form shows
"Too many failed login attempts from your IP address." A successful login clears the flood
counter.
