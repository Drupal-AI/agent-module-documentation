<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Location Signpost helps visitors find local-area services by address/postcode via OS Places and postcodes.io.

---

Location Signpost **signposts visitors to area-specific services by address/postcode** — a visitor enters an
address or postcode and is directed to services for their local area, using the Ordnance Survey Places API and
postcodes.io for lookup. It depends on core Block, Node and Link, and provides its own permissions.

Use it for local-service signposting (e.g. council sites). It is an integration/content feature. Security/data
handling: it **sends the visitor's address/postcode to external APIs** (Ordnance Survey Places, postcodes.io) —
that is **location data (PII)**, so disclose the third-party lookups in your privacy policy; the OS Places API
needs an **API key** stored as a secret (env/Key) over HTTPS. It has no access-control role beyond its permission.
Configure the API key and service mappings.

---

- Signpost local services by location.
- Look up address/postcode.
- Use OS Places + postcodes.io.
- Depend on core Block, Node, Link.
- Provide its own permissions.
- Serve local-service signposting.
- Send address/postcode to external APIs (location PII).
- Disclose the lookups per privacy policy.
- Store the OS Places API key as a secret (env/Key, HTTPS).
- Have no access-control role beyond permission.
- Configure the API key + mappings.
- Handle location signposting.
- Look up locations.
- Configure the APIs.
- Signpost services.
- Handle the integration.
- Find local services.
- Query postcodes.
- Secure the key.
- Provide location signposting.
