<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Availability does a parallel RDAP/WHOIS sweep across TLDs, with rate limiting and input sanitization.

---

Domain Availability checks a domain name across many TLDs in a single parallel sweep using RDAP and WHOIS, and deliberately never guesses: an unanswerable lookup reports "unknown", never "available". It provides an API (`/domain-check`), a search UI (`/domain-search`), a health endpoint, and an optional domain-registration request workflow.

It's built defensively: API/search routes are permission-gated (`use domain availability api`, `access domain availability search`, `administer domain availability`), input is run through a `DomainSanitizer`, and requests are rate-limited per client IP. Depends on core `file`, `options`, `user`, and `saudi_id_validator`; supports Drupal 10.3+ and 11.

---

- Check a domain across many TLDs.
- Sweep TLDs in parallel.
- Use RDAP and WHOIS.
- Report "unknown" not a guess.
- Provide a domain-check API.
- Provide a search UI.
- Offer a health endpoint.
- Support a registration-request workflow.
- Gate routes with dedicated permissions.
- Sanitize input via `DomainSanitizer`.
- Rate-limit per client IP.
- Depend on core `file`, `options`, `user`.
- Depend on `saudi_id_validator`.
- Support Drupal 10.3+ and 11.
- Avoid false positives.
- Check availability accurately.
- Manage registration requests.
- Handle unanswerable lookups safely.
