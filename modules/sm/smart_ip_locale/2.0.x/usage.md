<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart IP - Language Negotiation Redirect redirects users to a site language version based on their IP address (geolocated country).

---

Smart IP - Language Negotiation Redirect redirects visitors to a site language version based on their
IP-geolocated country — using the Smart IP module's geolocation to guess the visitor's country and send
them to the corresponding language. It depends on the Smart IP module.

Use it to auto-route visitors to a language by location. Note the caveats common to geo-based routing: (1)
IP geolocation is a **heuristic** (VPNs, proxies, mobile carriers, and inaccurate databases mean it's often
wrong), and (2) auto-redirecting by IP can frustrate users (and search-engine crawlers) and should not
override an explicit language choice — prefer suggesting over forcing where possible, and ensure a way to
switch back. It relies on correct client-IP handling (trusted-proxy config) for the geolocation to be
meaningful. It is a multilingual/negotiation feature with no access-control role. Configure the country→
language mapping.

---

- Redirect to a language by IP country.
- Use Smart IP geolocation.
- Route visitors by location.
- Depend on the Smart IP module.
- Know geolocation is a heuristic.
- Handle VPN/proxy inaccuracy.
- Not override explicit language choice.
- Provide a way to switch back.
- Rely on correct client-IP handling.
- Configure trusted proxies for geolocation.
- Mind crawler/user frustration.
- Prefer suggesting over forcing.
- Configure the country-to-language mapping.
- Have no access-control role.
- Auto-route by geography.
- Guess the visitor's country.
- Redirect by geolocation.
- Handle multilingual routing.
- Configure geo redirect.
- Route by IP.
