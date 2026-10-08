<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Checkpost protects a non-production site by rejecting every request that does not match a configured allowlist.

---
It registers an `http_middleware` (`CheckpostMiddleware`) that runs before routing. When enabled, a request is allowed only if its path matches an allowed page pattern, a configured header name/value is present, or the client IP matches an allowed IP (binary search) or CIDR range; otherwise it returns `403 Access Denied`. Settings live at `/admin/config/development/checkpost` (`administer site configuration`) storing enabled flag, pages, headers, IPs and CIDRs.

Operational note: allowlists (headers/IPs/CIDRs) come from admin config, not from request data. Setup: enable the module on staging, add your office IPs/CIDRs and any bypass header, then turn on enforcement.
---
- Lock a staging site to office IP addresses.
- Allow a CIDR range through the gate.
- Bypass the gate with a secret request header.
- Whitelist specific paths (e.g. health checks).
- Enable/disable enforcement from config.
- Return 403 to all other visitors.
- Protect a pre-launch site from crawlers.
- Combine IP and header allowlisting.
- Allow case-insensitive path matching.
- Match paths by alias or internal path.
- Keep cron/webhook paths reachable via header.
- Restrict configuration to administrators.
- Audit which IPs currently have access.
- Add a CDN/proxy IP to the allowlist.
- Temporarily open the site by disabling the module.
- Document the bypass header for CI.
