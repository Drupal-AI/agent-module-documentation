# Configure Restrict IP

Admin UI: **Configuration → People → Restrict IP** (`/admin/config/people/restrict_ip`, route
`restrict_ip.admin_page`, permission `administer restricted ip addresses`).

## Config object `restrict_ip.settings`

| Key | Type | Meaning |
|---|---|---|
| `enable` | bool | Master on/off for IP restriction (default `false`). |
| `mail_address` | email | Contact email shown to blocked users (may be empty). |
| `dblog` | bool | Log blocked access attempts to watchdog. |
| `allow_role_bypass` | bool | Allow the restriction to be bypassed per role (enables a dynamic permission). |
| `bypass_action` | string | For role-bypass + anonymous users: `provide_link_login_page` or `redirect_login_page`. |
| `white_black_list` | int | `0` = check all pages, `1` = check all except whitelisted pages, `2` = check only blacklisted pages. |
| `country_white_black_list` | int | `0` none, `1` whitelist countries, `2` blacklist countries (needs `ip2country`). |
| `country_list` | string\|null | Colon-separated country codes (needs `ip2country`). |

Read/write with drush:

```bash
drush cget restrict_ip.settings
drush cset restrict_ip.settings mail_address blocked@example.com -y
drush cset restrict_ip.settings allow_role_bypass true -y
```

## Where the IP list actually lives

The **Allowed IP Address List** (textarea on the form), the **Whitelisted pages** and
**Blacklisted pages** are **not** in `restrict_ip.settings`. They are persisted in the module's
own database tables through `RestrictIpMapper` and read/written via the `restrict_ip.service`
API — see [../api/service.md](../api/service.md) (`getWhitelistedIpAddresses()`,
`saveWhitelistedIpAddresses()`, `getWhitelistedPagePaths()`, `getBlacklistedPagePaths()`). The
list accepts one IP per line and supports ranges; `#` comments are stripped.

## settings.php overrides (deploy-as-code and lockout recovery)

```php
// Force an allowed IP list from code (in addition to the DB list):
$config['restrict_ip.settings']['ip_whitelist'] = ['111.111.111.1', '111.111.111.2'];

// Emergency unlock if you locked yourself out — disables the whole restriction:
$config['restrict_ip.settings']['enable'] = FALSE;
```

## Behaviour when enabled

An `kernel.request` event subscriber (`restrict_ip.service` → `RestrictIpEventSubscriber`)
checks the client IP on every request. Non-allowed visitors are blocked and shown the Access
Denied page (route `restrict_ip.access_denied_page`, path `/restrict_ip/access_denied`, always
publicly accessible). Drush/CLI requests are not blocked. Country filtering only appears/works
when the optional `ip2country` module is enabled.
