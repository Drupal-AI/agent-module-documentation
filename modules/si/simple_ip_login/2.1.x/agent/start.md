<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple IP Login — agent index

**Auto-logs a user in when their client IP matches** a configured IP wildcard rule (admin maps IP →
user; `user_login_finalize()`, no password). Config at the IP Wildcard collection; provides
permissions. Version **2.1.1**. Core `^9||^10||^11`.

**SECURITY — trusted networks only** (same model as `ip_login`). Grants a full session by source IP.
Shared IPs (NAT/CGNAT/VPN) = everyone becomes the mapped user; never map admins there. Uses
`getClientIp()` (honours trusted-proxy config, not blind XFF) — **but** if `settings.php` trusts all
proxies, `X-Forwarded-For` spoofing → impersonate any mapped user. Risk is in deployment/config.
