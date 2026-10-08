Restrict IP locks a whole Drupal site down to an administrator-defined allowlist of IP addresses: any visitor whose IP is not on the list is shown an "Access Denied" page instead of the requested content, with options to bypass by role, whitelist/blacklist specific paths, and (with ip2country) allow/deny by country.

---

When enabled, the module registers an event subscriber on `kernel.request` that runs early and, for every request, checks the visitor's client IP against the allowed list. If the IP is not allowed the user is blocked: no blocks render, no JavaScript is added, and they are shown a themeable Access Denied page (route `restrict_ip.access_denied_page`). The allowed IP list, whitelisted pages, and blacklisted pages are stored in the module's own database tables (via `RestrictIpMapper`), while behavioural settings live in the `restrict_ip.settings` config object: `enable`, `mail_address` (a contact email shown to blocked users), `dblog` (log attempts to watchdog), `allow_role_bypass` + `bypass_action`, `white_black_list` (check all pages / whitelist / blacklist), and `country_white_black_list` + `country_list` (only when the optional `ip2country` module is present). Admins configure everything at `/admin/config/people/restrict_ip` (permission "administer restricted ip addresses"; a dynamic per-role "bypass" permission is also provided when role bypass is enabled). The allowlist and the enable flag can additionally be forced from `settings.php` via `$config['restrict_ip.settings']['ip_whitelist']` and `['enable']` — the documented way to unlock yourself if you get locked out. A Drush command `restrict_ip:disable` (alias `ripd`) toggles the enable flag from the CLI, and three alter hooks let a theme/module whitelist regions and JS or alter the Access Denied page. The core service is `restrict_ip.service` (`RestrictIpService`).

---

- Restrict an entire staging or pre-launch site to the office/VPN IP range so the public cannot see it.
- Lock a Drupal admin/back-office site to a fixed set of known IP addresses.
- Show blocked visitors a friendly Access Denied page with a contact email to request access.
- Whitelist trusted office IPs in `settings.php` (`$config['restrict_ip.settings']['ip_whitelist']`) so the list is deployed as code.
- Emergency-unlock a site you locked yourself out of by adding `$config['restrict_ip.settings']['enable'] = FALSE;` to `settings.php`.
- Enable or disable IP restriction from the command line during a deploy with `drush ripd enable` / `drush ripd disable`.
- Allow certain user roles to bypass the IP restriction (e.g. authenticated editors working from home).
- Redirect bypassing-but-anonymous users to the login page instead of showing the block message.
- Restrict most of the site but whitelist specific public paths (e.g. `/`, `/contact`) so they stay reachable.
- Do the inverse: leave the site open but blacklist a few sensitive paths to the IP allowlist only.
- Allow or deny visitors by country using the companion ip2country module (whitelist/blacklist a country list).
- Log every blocked access attempt to Drupal's log (watchdog) for auditing.
- Support IP ranges/CIDR-style entries in the allowed address list.
- Keep the Access Denied page functional for logged-in users by whitelisting the logout link.
- Whitelist specific page regions so a header/footer still renders on the Access Denied page (`hook_restrict_ip_whitelisted_regions`).
- Whitelist specific JavaScript files that must load even when access is denied (`hook_restrict_ip_whitelisted_js_keys`).
- Add extra information to, or completely rewrite, the Access Denied page from a theme/module (`hook_restrict_ip_access_denied_page_alter`).
- Redirect denied users to an external site by sending a RedirectResponse from the access-denied alter hook.
- Provide a temporary IP-gated preview of a site to a client at a known address.
- Comply with a policy that limits CMS access to corporate networks only.
- Combine role bypass with an IP allowlist so staff work anywhere but anonymous traffic is limited to certain IPs.
- Read or set the allowed IP list, page whitelist/blacklist programmatically through the `restrict_ip.service` API.
- Temporarily restrict a site during an incident, then flip it back on with a single Drush command.
