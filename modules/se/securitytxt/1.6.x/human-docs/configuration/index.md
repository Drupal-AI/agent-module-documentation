# Configuration

Everything is entered on one settings form and stored in a single configuration object.
There are three things to get right: fill in at least one contact, tick **Enabled**,
and grant the **View securitytxt** permission so the file is actually reachable.

## Open the settings form

1. Log in as a user with the **Administer securitytxt** permission.
2. Go to **Configuration → System → Security.txt**
   (`/admin/config/system/securitytxt`).

## The fields

Each field maps to a line in the published file. You only need to fill in the ones you
want to publish.

- **Enabled** — the master switch. While this is off (the default), the
  `/.well-known/security.txt` path returns 404. The form will not let you save it as
  enabled unless you have set at least one contact method (below).
- **Contact email** — produces a `Contact: mailto:` line, e.g. `security@example.com`.
- **Contact phone** — produces a `Contact: tel:` line. Use full international format,
  e.g. `+1-201-555-0123`.
- **Contact page URL** — produces a `Contact:` line pointing at a reporting page. Use
  HTTPS; the form warns if you do not.
- **Encryption key URL** — an `Encryption:` line pointing at your PGP public key, for
  researchers who want to send an encrypted report.
- **Expires** — an `Expires:` date telling researchers the file is still current. This
  is **required** by the form. Set it a reasonable time out (many sites use a year).
- **Policy URL** — a `Policy:` line linking your written security/disclosure policy.
- **Acknowledgments URL** — an `Acknowledgments:` line linking a hall‑of‑fame page that
  credits researchers.
- **Hiring URL** — a `Hiring:` line advertising security job openings.
- **Preferred languages** — a `Preferred-Languages:` line, a comma list such as
  `en, fr`. Defaults to your site's default language.
- **Canonical URLs** — one `Canonical:` line per URL, declaring the authoritative
  location(s) of the file. Only lines beginning with `https://` are published.

Click **Save configuration**, then clear caches (`drush cr`) so the served file
reflects your changes.

## Grant the view permission (important)

The published file is deliberately put behind a permission rather than being
world‑readable. For scanners and researchers to reach it, you **must** grant the **View
securitytxt** permission to the **Anonymous** role (and usually **Authenticated** too):

```bash
drush role:perm:add anonymous 'view securitytxt'
drush role:perm:add authenticated 'view securitytxt'
```

## Signing the file (optional)

To publish a PGP‑signed file:

1. Open the **Sign** subtab at **Configuration → System → Security.txt → Sign**
   (`/admin/config/system/securitytxt/sign`).
2. Paste your detached PGP signature and enable signing.

The signed file is served at `/.well-known/security.txt`, and the detached signature at
`/.well-known/security.txt.sig`.

## Check it worked

```bash
curl -s https://your-site.example/.well-known/security.txt
```

When the module is enabled and a contact is set, this returns the plain‑text file. When
disabled it returns a 404.

## Permissions

- **View securitytxt** — allows reading `/.well-known/security.txt` (and `.sig`). Grant
  it to Anonymous and Authenticated.
- **Administer securitytxt** — allows editing the settings and Sign forms. This is a
  restricted permission — grant it only to trusted admin roles.
