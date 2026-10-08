# Configuration

## Add a protected page

1. Log in as a user with the permission to administer Protected Pages Extra.
2. Go to **Configuration → Content authoring → Protected Pages Extra**
   (`/admin/config/content/protected-pages-extra`).
3. Click **Add page protection**.
4. Enter one or more **URL paths** to protect — for example `/members` or
   `/private/documents`. You can list several paths in one entry so they share a single
   password, and you can use **wildcards** to protect a whole section at once.
5. Set the **password** for those paths.
6. **Save.**

From then on, any visitor who requests one of those paths without having unlocked it
sees the "Enter Password" screen instead of the page. Because authentication is
session‑aware, once they enter the correct password they won't be prompted again in the
same session for any other page protected by the same password.

## Other options

- **Global password** — set a site‑wide password that applies to protected pages,
  instead of (or in addition to) a per‑entry password.
- **Session expire time** — how long an unlock lasts before the visitor is prompted
  again.
- **"Enter Password" screen text** — customize the wording shown on the password form.
- **Private file protection** — set a password for protected private files.
- **Email notification** — send an email to inform users about a protected page.

## Permissions

Assign the module's permissions on **People → Permissions**
(`/admin/people/permissions`). Keep the administrative and bypass permissions to
trusted roles:

- **Administer protected pages extra** — full administrative access to the module and
  its settings.
- **Create and edit protected page** — add and edit protected page entries.
- **Delete protected page** — remove protected page entries.
- **Access protected page extra password screen** — see the password prompt when the
  module redirects to it. Grant this to anonymous and authenticated users if
  non‑privileged visitors should be able to unlock pages; without it they get an
  "access denied" instead of the prompt.
- **Bypass protected page access check** — visit any protected page without being
  prompted. This is the most sensitive permission — grant it **only** to trusted roles.
