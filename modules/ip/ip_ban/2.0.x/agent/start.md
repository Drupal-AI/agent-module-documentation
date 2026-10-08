<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IP Ban — agent index

**Bans access by IP address or by country** (GeoIP via `ip2country`). Depends on `ip2country`, core `path_alias`.
Provides permissions. Version **2.0.x** (dev). Core `^9||^10||^11`.

**Coarse gate, not strong security** — IP is changeable (VPN/proxy; spoofable) + GeoIP approximate: reduce noise/
abuse, not protect content or as the only access control; beware self-lockout. No per-content access role.
