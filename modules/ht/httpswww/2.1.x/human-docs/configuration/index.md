# Configuration

All the settings live on one form, and there are two permissions to understand
before you touch it.

## Open the settings form

Go to **Configuration → System → HTTPS and WWW Redirect**
(`/admin/config/system/httpswww`). You need the *Administer HTTPS and WWW Redirects*
permission. The values are stored in the `httpswww.settings` config object.

## The options

- **Enable redirects** (`enabled`) — the master switch. While this is off, nothing
  is redirected, no matter what the other options say.
- **Domain WWW prefix** (`prefix`) — how to handle `www.`:
  - **No redirect** (`mixed`, the default) — leave the host alone; both
    `example.com` and `www.example.com` work.
  - **Remove WWW prefix** (`no`) — redirect `www.example.com` down to
    `example.com`.
  - **Add WWW prefix** (`yes`) — redirect `example.com` up to `www.example.com`.
- **Exclude Subdomains** (`exclude_subdomains`) — a comma-separated list, **only
  used when "Add WWW prefix" is selected**. Subdomains you list here keep their bare
  host and are not given `www.` (for example `api`, `shop`). It is ignored for the
  other prefix modes.
- **HTTP Secure (HTTPS) redirect** (`scheme`) — how to handle the scheme:
  - **No redirect** (`mixed`, the default) — both HTTP and HTTPS work.
  - **Redirect to HTTPS** (`https`) — send any `http://` request to `https://`.

Save when you are done. Changes take effect on the next request.

## Common setups

- **Force HTTPS everywhere:** set **Enable redirects** on and **HTTPS redirect** to
  *Redirect to HTTPS*.
- **Prefer the bare domain:** set **Domain WWW prefix** to *Remove WWW prefix*.
- **Prefer `www.` but keep `api.` and `shop.` bare:** set **Domain WWW prefix** to
  *Add WWW prefix* and list `api, shop` under Exclude Subdomains.
- **Turn it all off during an incident** without losing your choices: just untick
  **Enable redirects**.

You can also drive this from the command line, e.g. to force HTTPS:

```bash
drush php:eval '\Drupal::configFactory()->getEditable("httpswww.settings")
  ->set("enabled", TRUE)->set("scheme", "https")->save();'
```

And read the current policy back:

```bash
drush config:get httpswww.settings
```

To return to the shipped "do nothing" baseline, delete the config object entirely
rather than resetting each key: `drush config:delete httpswww.settings`.

## The two permissions

Both are flagged security-sensitive and are granted to no role by default. Set them
at **People → Permissions** (`/admin/people/permissions`):

| Permission | Machine name | What it does |
|---|---|---|
| **Administer HTTPS and WWW Redirects** | `administer httpswww` | Who can open and change the settings form. |
| **Bypass HTTPS and WWW Redirects** | `bypass httpswww redirect` | Exempts the user from the redirect entirely — they are never redirected, no matter what the settings say. |

The **bypass** permission matters operationally: without it, saving a change while
you are on a different host or scheme than the one you are selecting can immediately
log you out or redirect you away, because your own next request gets redirected.
Grant it to your administrator role before experimenting. It only affects who is
*subject* to the redirect — not who can change the configuration.
