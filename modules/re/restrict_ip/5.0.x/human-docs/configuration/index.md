# Configuration

All of Restrict IP's behaviour is controlled from one form.

## Open the settings form

1. Log in as a user with the **Administer restricted IP addresses** permission
   (an administrator by default).
2. Go to **Configuration → People → Restrict IP**, or navigate directly to
   `/admin/config/people/restrict_ip`.

> **Before you enable it:** add the IP address you are browsing from to the
> allowed list first, so you do not lock yourself out.

## Enable Restricted IPs

The master switch. Until this checkbox is ticked, the module does nothing and the
whole site stays open. Tick it to activate IP filtering (this is the same flag the
`drush ripd enable` / `drush ripd disable` command toggles).

## Allowed IP Address List

The heart of the module: a textarea where you list the addresses that are allowed
in, **one per line**. IP ranges are supported, and you can annotate lines with
`#` comments (the comment is stripped before matching). Any visitor whose address
is not matched here is blocked.

Note that this list — along with the page whitelist/blacklist below — is stored in
the module's own database tables, not in exported configuration. If you want the
allowlist to travel with your code, see the `settings.php` override further down.

## Email address for blocked users

An optional contact email shown on the Access Denied page, so a blocked visitor
knows who to ask for access. Leave it empty to show no contact address.

## Log access attempts

When ticked, every blocked request is written to Drupal's log (watchdog / *Recent
log messages*), which is useful for auditing who is being turned away.

## Allow role bypass

When ticked, this exposes a per‑role **bypass permission** so that trusted roles
can skip the IP check entirely — for example editors working from home. Grant the
bypass permission to those roles on the *People → Permissions* page. A companion
setting, **bypass action**, controls what an anonymous visitor who *would* be
allowed to bypass sees:

- **Provide a link to the login page** — show the block page with a login link.
- **Redirect to the login page** — send them straight to log in.

If role bypass is left off, the bypass permission is not offered at all.

## Page restriction (white/blacklist)

Controls which paths the IP check applies to:

- **Check all pages** *(default)* — the restriction covers the entire site.
- **Check all pages except whitelisted pages** — the site is restricted, but the
  paths you list stay publicly reachable (handy for keeping `/` or `/contact`
  open, or the logout link working).
- **Check only blacklisted pages** — the site is open, but the few paths you list
  are restricted to the IP allowlist.

When you pick the whitelist or blacklist option, a textarea appears for the paths
(one per line).

## Country restriction

These options appear **only when the optional
[ip2country](https://www.drupal.org/project/ip2country) module is enabled**. They
let you allow or deny visitors by country:

- Choose **whitelist countries** (only listed countries allowed) or **blacklist
  countries** (listed countries denied).
- Pick the country list to apply.

## Save

Click **Save configuration**. If you enabled the restriction, it takes effect
immediately — test from an address that is *not* on the list (or a different
network) to confirm the Access Denied page appears. Command‑line/Drush requests
are never blocked.

## settings.php overrides and lockout recovery

Two values can be forced from `settings.php`, which is the recommended way to
deploy the allowlist as code and to rescue yourself if you get locked out:

```php
// Force an allowed IP list from code (added to the list in the database):
$config['restrict_ip.settings']['ip_whitelist'] = ['111.111.111.1', '111.111.111.2'];

// Emergency unlock — disables the whole restriction regardless of the UI setting:
$config['restrict_ip.settings']['enable'] = FALSE;
```

Because these live in `settings.php`, they cannot be changed from the browser and
always win, so the second line is a reliable way back in if you ever shut yourself
out.
