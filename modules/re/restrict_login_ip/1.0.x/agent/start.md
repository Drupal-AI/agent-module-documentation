<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Restrict Login Page by IP — agent index

Restricts the **user login page to an allow-list of IPs/CIDR ranges** (login reachable only from approved
networks — office/VPN). Allows if no ranges set (off until configured); denies if request unavailable
(fail-closed). Depends on core `user`. Config at `restrict_login_ip.settings`. Version **1.0.0**. Core
`^10||^11`.

**Security:** uses `getClientIp()` (correct — honours trusted-proxy config, not blind XFF); **but** if
`settings.php` trusts all proxies, `X-Forwarded-For` spoofing bypasses it — configure trusted proxies
first. Keep an allowed network for admins (don't lock yourself out); confirm all login entry points are
covered.
