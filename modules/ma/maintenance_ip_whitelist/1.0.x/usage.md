<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maintenance IP Whitelist allows a configured list of IP addresses to continue browsing a site that is in
maintenance mode — even as anonymous users. It is useful for letting a client, QA team, or office network
preview a site during a maintenance window without granting them accounts or the
`access site in maintenance mode` permission. Configuration is added directly to the core maintenance-mode
form at `/admin/config/development/maintenance`.

---

The module decorates the core `maintenance_mode` service
(`maintenance_ip_whitelist.maintenance_mode.decorator`, `decorates: maintenance_mode`,
priority 1) with `MaintenanceModeDecorator`. Its `exempt()` override reads the newline-separated
whitelist from `state` (`maintenance_ip_whitelist`), trims/filters it, and returns `TRUE` (exempt from
maintenance mode) when the visitor's IP is in the list; otherwise it delegates to the decorated core
service. The whitelist textarea is injected into the `system_site_maintenance_mode` form via
`hook_form_alter` (`FormOperations::formAlter`) and saved to state by a submit handler. There are no
routes or permissions of the module's own; the injected field inherits the maintenance-mode form's
`administer site configuration` gating.

**Security note (verified):** the IP is read from **`$_SERVER['REMOTE_ADDR']`** — the actual TCP peer
address — **not** from a client-supplied header such as `X-Forwarded-For`. That means the whitelist is
**not spoofable** via request headers, which is the safe choice. (Caveat for operators: behind a reverse
proxy/load balancer, `REMOTE_ADDR` is the proxy's IP, so admins must whitelist the real client IPs as the
proxy presents them, or the check will not match end-user IPs — a configuration concern, not a
vulnerability.)

---

- Let a client preview a site during a maintenance window from their office IP.
- Allow QA/staging testers through maintenance mode without accounts.
- Whitelist your own IP so you can browse anonymously during maintenance.
- Grant temporary anonymous access to a specific network range's egress IP.
- Add multiple IPs, one per line, on the core maintenance form.
- Keep the site in maintenance mode for the public while insiders browse.
- Avoid handing out the `access site in maintenance mode` permission.
- Use the TCP peer IP so the allowlist cannot be spoofed by headers.
- Store the allowlist in state (not exported config) for per-environment control.
- Combine with core maintenance mode for a controlled soft-launch.
- Let a monitoring host's IP keep checking the site during maintenance.
- Preview deploys from a VPN exit IP.
- Remove an IP to immediately revoke maintenance access.
- Delegate whitelist management to holders of `administer site configuration`.
- Provide contractor access without creating Drupal users.
- Show maintenance page to everyone except a short, explicit IP allowlist.
