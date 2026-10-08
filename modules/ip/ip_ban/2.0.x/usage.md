<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IP Ban bans access by country or by IP address.

---

IP Ban **bans access by IP address or by country** — blocking requests from specific IPs or (via ip2country
GeoIP) whole countries, to keep out unwanted/abusive traffic. It depends on the IP2Country and core Path Alias
modules, provides its own permissions, in the Location package.

Use it for coarse IP/country blocking. Understand its limits: IP/country banning is a **coarse, best-effort
gate, not a strong security boundary** — the client IP can be **changed via VPN/proxy** (and header-spoofed
unless trusted proxies are configured), and **GeoIP is approximate** — so a determined attacker bypasses it; use
it to reduce noise/abuse, not to protect sensitive content or as your only access control. Beware **locking
yourself out** if you ban your own IP/country. It has no per-content access-control role. Configure the IP/country
bans.

---

- Ban access by IP or country.
- Block specific IPs.
- Block whole countries (GeoIP).
- Depend on IP2Country and core Path Alias.
- Provide its own permissions.
- Reduce unwanted/abusive traffic.
- BE a coarse, best-effort gate (not strong security).
- Know IP is changeable (VPN/proxy) + GeoIP approximate.
- Configure trusted proxies if relying on IP.
- Not use it as the only access control.
- Beware locking yourself out.
- Configure the IP/country bans.
- Handle IP banning.
- Ban IPs.
- Configure the bans.
- Block countries.
- Handle the gate.
- Restrict traffic.
- Treat it as best-effort.
- Provide IP/country banning.
