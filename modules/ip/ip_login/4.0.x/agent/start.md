<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP Login — agent index

**Auto-logs a user in when their client IP matches** a configured IP/range/wildcard (per-user, via
Field IP address) — early middleware calls `user_login_finalize()`, **no password**. Depends on
`user`, `field_ipaddress`. Config at `ip_login.settings`. Version **4.0.0-beta2**. Core
`^8.9||^9||^10||^11`.

**SECURITY — trusted networks only.** Grants a full session by source IP. Shared IPs (NAT/CGNAT/
office/VPN) = everyone becomes the mapped user. Uses `getClientIp()` (correct — honours trusted-proxy
config, not blind XFF), **but** if `settings.php` trusts all proxies an attacker can spoof
`X-Forwarded-For` → impersonate any mapped user. Never map admin accounts on shared networks. Risk is
in deployment/config, which the adopter owns.
