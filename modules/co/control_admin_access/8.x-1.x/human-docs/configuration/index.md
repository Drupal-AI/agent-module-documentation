# Configuration

Control Admin Access has a single settings form with two fields. Together they say
"only these IP addresses may reach these URLs; block everyone else." Read this
page fully before saving — an incorrect rule can lock you out of your own admin
area.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default — the module provides its own permission for changing these rules).
2. Go to **Configuration → System → Control admin access**, or navigate directly
   to `/admin/config/system/control-admin-access`.

## The access model

The two fields work as an **allowlist plus a protected‑URL list**:

- Visitors whose IP is on the allowlist get unrestricted access to the whole site,
  including the protected URLs.
- Visitors whose IP is **not** on the allowlist are blocked from the protected
  URLs — even if they are administrators or otherwise privileged — and receive an
  access error.

So access to a protected URL is granted only when the request comes from an
allowlisted IP.

## Field 1 — Enter IPs or IP ranges (Whitelist)

Enter the IP addresses or ranges that should be allowed through. You can list:

- a single address, for example `192.168.1.10`
- a CIDR range, for example `10.0.0.0/24`

Add every address you genuinely need — including your own current IP and any
office, VPN, or CI addresses — before you save, so you do not lock yourself out.
Remember that behind a reverse proxy or load balancer the IP Drupal sees is only
trustworthy if you have configured trusted proxies in `settings.php`; otherwise
the client IP can be spoofed through `X-Forwarded-For`.

## Field 2 — Enter URLs to block except for Whitelist

Enter the URLs (paths) you want to protect — one per line. Only requests from the
allowlisted IPs in Field 1 will be able to reach them; everyone else is blocked.
For example:

```
/admin/settings
/user/1/edit
```

Use this to fence off the admin area or other sensitive paths. Be as specific as
your needs require.

## Save

Click **Save configuration**. The rules take effect immediately, so confirm you
can still reach the protected URLs from your allowlisted IP right away. If you find
yourself locked out, recover by editing the module's configuration through
`drush config:edit` (or the database) to correct or clear the rules.

## A reminder on scope

IP restriction is a **hardening layer, not authentication**. The client IP is
spoofable unless trusted proxies are configured correctly, so keep strong login
security in place and treat this module as one part of a defense‑in‑depth setup
rather than your only line of defense.
