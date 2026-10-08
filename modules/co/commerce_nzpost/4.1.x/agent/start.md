<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce NZ Post (commerce_nzpost) — agent index
**Commerce Shipping method that fetches live international rates from the NZ Post RateFinder API.**

- **Version:** 4.1.x
- **Core:** ^9 || ^10
- **Depends on:** `drupal:commerce`, `drupal:commerce_shipping`
- **Plugin:** `NzPost` shipping method → `RateLookupService` (`commerce_nzpost.rate_lookup`).
- **API:** `GET https://api.nzpost.co.nz/ratefinder/international.json` (HTTPS, Guzzle); API key sent as query param; returns rates by service code. Domestic `NZ` destinations return no rates by design.
- **Security:** No routes, permissions, or anonymous endpoints; outbound call is HTTPS with no disabled TLS. API key stored in the shipping-method config. Minor code issue: `RequestException` caught without a `use` import (robustness, not security).
