<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brreg API (brreg_api) — agent index
**Service client for Norway's Brreg (Enhetsregisteret) company registry.**

- **Version:** 1.0.x  •  **Core:** ^8 || ^9 || ^10 || ^11
- **Service:** `brreg_api.client` → `Drupal\brreg_api\BrregClient` (ctor: `@http_client`)
- **Methods:** `getCompany($number)`, `getSubdivisions($number)`, `getByName(string $name)`
- **Endpoint:** `https://data.brreg.no/enhetsregisteret/api` (HTTPS, public, no auth)
- **Security:** no routes/permissions/UI; outbound HTTPS with default TLS verify; org numbers sanitised to digits. No security findings.

See [api/client.md](api/client.md).