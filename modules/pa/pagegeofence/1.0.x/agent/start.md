<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Page Geofence — agent index

Restricts **page access by visitor country** — rules (paths/wildcards, allow/deny by country, redirect
or 403), processed by weight. Depends on core `field`, `system`, `user`. Config at
`entity.pagegeofence_rule.collection`; provides permissions. Version **1.0.0-alpha3**. Core
`^8||^9||^10||^11`.

**Soft control, NOT a security boundary:** geo-IP is **VPN/proxy-bypassable** and depends on correct
client IP (configure trusted proxies). Use for policy/UX geoblocks (licensing/regional content), not to
protect sensitive content — use real access control for that.
