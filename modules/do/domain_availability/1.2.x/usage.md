<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Availability does a parallel RDAP/WHOIS sweep across TLDs, with rate limiting and input sanitization. Version 1.2.0 adds Drupal 12 compatibility.

---

Domain Availability checks a domain name across many TLDs in a single parallel sweep using RDAP and WHOIS, and deliberately never guesses: an unanswerable lookup reports "unknown", never "available". It provides a JSON API (`/domain-check`), a search UI (`/domain-search`), a health endpoint (`/domain-check/health`), an optional per-extension pricing subsystem, and an optional Saudi domain-registration request workflow.

It's built defensively: API/search/admin routes are permission-gated (`use domain availability api`, `access domain availability search`, `administer domain availability`), user input is reduced to a bare LDH label through `DomainSanitizer` and `DomainValidator` before any network operation, lookups target only registry-controlled WHOIS/RDAP servers (never a user-supplied host), and requests are rate-limited per client IP. CORS origins are echoed only from an explicit allow-list. Depends on core `file`, `options`, `user`, and `saudi_id_validator`; supports Drupal 10.3+, 11 and 12 on PHP 8.3+. Release 1.2.0 is a compatibility/refactor release with no behavioural or public-API change from 1.1.x.

---

- Check whether a domain name is registered across many TLDs at once.
- Sweep every configured TLD in one parallel request.
- Resolve availability via RDAP first, WHOIS second, DNS as a last fallback.
- Report "unknown" instead of guessing when no authority can answer.
- Expose a JSON lookup API at `/domain-check`.
- Offer a search UI at `/domain-search`.
- Place a domain-availability search block from Block Layout.
- Embed a search element in Twig with `domain_availability_search()`.
- Query availability from PHP via the `domain_availability.checker` service.
- Discover RDAP endpoints automatically from the IANA bootstrap, cached.
- Discover WHOIS servers through `whois.iana.org`, cached, for unmapped TLDs.
- Cache lookup results with a configurable TTL to cut outbound traffic.
- Rate-limit lookups per client IP by request count and minimum interval.
- Attach a per-extension or fixed price to available results.
- Add a new lookup protocol as one tagged `domain_availability_provider` service.
- Add a new pricing model as one tagged `domain_availability_pricing_strategy` service.
- Monitor WHOIS egress (port 43) from the status report or the health endpoint.
- Collect Saudi domain registration requests through a modal workflow.
- Validate Saudi national IDs through the `saudi_id_validator` dependency.
- Review, approve, reject, cancel and delete registration requests in the admin UI.
- Store certificate uploads in the private filesystem when the site has one.
- Restrict CORS access to an explicit list of allowed origins.
- Run on Drupal 10.3, 11 or 12 with no database update when upgrading from 1.1.x.
