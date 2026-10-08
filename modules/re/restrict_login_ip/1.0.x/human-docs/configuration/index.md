# Configuration

The module does nothing until you configure the allowed IP addresses. Everything on
this page is about setting that list safely.

## Open the settings form

1. Log in as an administrator, **from a network you will keep on the allow-list**.
2. Go to **Configuration → People → Restrict Login Page by IP**, or navigate directly
   to `/admin/config/people/restrict_login_ip`.

## Allowed IP addresses / ranges

This is the core setting: a list of IP addresses or ranges (in **CIDR** format)
**separated by semicolons**. Once it contains at least one entry, the login page is
reachable only from matching addresses; every other IP receives a `403`.

- **Leave it empty** and the feature is off — login is open to all IPs.
- **Add your office/VPN ranges** (for example `203.0.113.0/24;198.51.100.42`) to lock
  login to those networks.

> **Avoid locking yourself out.** Always include the network you administer the site
> from *before* saving, and test from that network. If you set ranges that exclude
> your own IP, you will be locked out of the login page just like everyone else.

You can also set the list in `settings.php` instead of (or as well as) the form:

```php
$config['restrict_login_ip.settings']['ip_ranges'] = '203.0.113.0/24;198.51.100.42';
```

## Extended protection options (1.1.x)

Later releases in this branch add further options on the same settings page:

- **Protect additional login-related pages** — optionally extend the restriction
  beyond `/user/login` to user registration, password reset, one-time login links,
  the login status endpoint and the `/user` page.
- **Return 404 instead of 403** — make the restricted pages appear not to exist at
  all, rather than returning a "forbidden" response.

If your installed version shows these options, choose them to suit how much of the
login surface you want to cover and how visible you want the restriction to be.

## Save

Click **Save configuration**. The restriction takes effect immediately, so confirm
you can still reach `/user/login` from your own network right after saving.

## Important limits and recovery

- **It restricts the login *page*, not all authentication.** Other methods (SSO,
  basic auth) are not blocked and can bypass the IP check; the status report warns you
  when another authentication method that could bypass it is enabled. Confirm all your
  login entry points are covered.
- **Behind a proxy/CDN**, configure `reverse_proxy` and `trusted_host_patterns` in
  `settings.php` first, so the module reads the real client IP and cannot be fooled by
  a spoofed `X-Forwarded-For`.
- **If you are locked out**, clear the allowed ranges from the command line and rebuild
  caches — for example:

  ```bash
  drush config:set restrict_login_ip.settings ip_ranges '' -y
  drush cr
  ```

  (Prefix with `ddev` if you run it from your host with DDEV.) With the list empty the
  login page reopens to all IPs, and you can set a correct range again.
