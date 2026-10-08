# Configuration

Protected Pages Extra has two parts: individual **protected page** entries (each one a
config entity), and a **settings form** that governs passwords, sessions, flood
control, email, and the IP allowlist.

## Add a protected page

1. Log in as a user with **Administer protected pages extra** (or **Access protected
   pages extra overview page** plus **Create and edit protected page**).
2. Go to **Configuration → System → Protected Pages Extra**
   (`/admin/config/system/protected-pages-extra`) and add a page.
3. Give it a **title** (an admin label), and one or more **paths**. Paths are internal
   paths like `/node/5` or wildcard patterns like `/news/*`. Several paths in one entry
   share the same password.
4. Set a **password**. (When you later edit the entry, leaving the password blank keeps
   the existing one.)
5. Optionally allow the password to be passed in the URL as `?password=…` for this
   entry — an opt‑in convenience, off by default.
6. **Save.** Each entry is stored as `protected_pages_extra.page.<id>` and is
   exportable with `drush cex`.

## Settings form

At **Configuration → System → Protected Pages Extra → Settings**
(`/admin/config/system/protected-pages-extra/settings`):

### Passwords and sessions

- **Password mode** — choose **per‑page password** (default), **per‑page or global**
  (either is accepted), or **only global**.
- **Global password** — a site‑wide password used by the global modes. Leaving it blank
  on save keeps the stored one.
- **Session expire time** — in minutes; `0` means unlimited. Once this elapses, a
  visitor is re‑prompted even if they unlocked the page earlier.

### Login screen text

Customize the login form's **title**, **description**, **password label**, **submit
button text**, and **incorrect‑password message**. (The description and error message
are run through admin‑grade filtering.)

### Brute‑force / flood control

Failed password attempts are rate‑limited on two axes using core's flood service:

- **Per IP** — attempts allowed per IP before lockout (default 50 attempts per hour).
- **Per page (per IP)** — attempts allowed against a single page from one IP (default
  10 per hour).
- **IP allowlist** — a list of single IPs or inclusive ranges (IPv4 and IPv6). An
  allowlisted IP skips the flood limits entirely, though the password check still runs.
  Manage it with the add/remove table on the settings form.

### Email notifications

Configure the **subject**, **body**, and **wildcard text** used by the per‑entry "Send
email" operation, which tells recipients about a protected page. Body tokens include
`[protected-page-urls]`, `[protected-page-wildcard-text]`, and `[site-name]`; inside the
wildcard text you can use `[protected-page-wildcard-urls]`. The password is never
included in an email.

## Permissions

Assign these on **People → Permissions** (`/admin/people/permissions`):

- **Administer protected pages extra** — settings form and full admin access.
- **Access protected pages extra overview page** — view the list of protected pages.
- **Create and edit protected page** — add/edit entries and send notification emails.
- **Delete protected page** — remove entries.
- **Access protected page extra password screen** — see the login form when the
  middleware redirects to it. Grant to anonymous and authenticated visitors who should
  be able to unlock pages; without it they get a 403 instead of the prompt.
- **Bypass protected page access check** — visit any protected page without a prompt.
  The most sensitive permission — grant it **sparingly**, to trusted roles only.

## Keeping passwords out of config export

Because entries and settings are ordinary config, `drush cex` writes their password
hashes. To vary passwords per environment and keep them out of git, use the Config
Ignore module, for example:

```yaml
# config_ignore.settings.yml
ignored_config_entities:
  - protected_pages_extra.page.*
```

The same pattern works for `protected_pages_extra.settings` to vary the global password
per environment.

## Translating login and email strings

With the core **Configuration Translation** module installed, the login and email
strings can be translated per language at **Configuration → Regional and language →
Configuration translation**.
