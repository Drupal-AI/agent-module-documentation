<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart IP - Language Negotiation Redirect — agent index

Redirects visitors to a **language/site version based on IP-geolocated country** (via Smart IP). Depends on
`smart_ip`. Version **2.0.3**. Core `^9||^10||^11`.

**Caveats:** IP geolocation is a **heuristic** (VPN/proxy/mobile/DB inaccuracy); auto-redirect can frustrate
users/crawlers — don't override explicit choice, provide a switch-back; relies on correct client-IP
(trusted-proxy) handling. Multilingual/negotiation; no access role.
