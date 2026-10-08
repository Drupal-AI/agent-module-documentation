<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IPstack provides ipstack.com API integration.

---

IPstack integrates the **ipstack.com IP-geolocation API** — looking up geolocation (country/region/city) for
an IP address via ipstack's service, usable for geo-targeting/analytics. It provides its own permissions, in the
Development package.

Use it to geolocate IP addresses. It is an integration feature. Security/data handling: it sends **IP addresses
to ipstack** (external egress; an IP is personal data under some regimes) and authenticates with an **ipstack
API access key** — store it as a **secret** (env/Key) over HTTPS. It has no access-control role beyond its
permission. Configure the ipstack access key.

---

- Geolocate IPs via ipstack.
- Look up country/region/city.
- Support geo-targeting/analytics.
- Provide its own permissions.
- Use ipstack.com's API.
- Serve integration.
- Send IPs to ipstack (egress; IP is personal data).
- Store the ipstack access key as a secret.
- Use HTTPS.
- Have no access-control role beyond permission.
- Configure the access key.
- Handle IP geolocation.
- Geolocate IPs.
- Configure the key.
- Look up IPs.
- Handle the integration.
- Geo-target.
- Query ipstack.
- Secure the key.
- Provide IP geolocation.
