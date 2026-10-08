<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domain Availability — agent index

**Parallel RDAP/WHOIS domain-availability** sweep (reports unknown, never guesses). Version **1.2.0** (branch 1.2.x). Core `^10.3 || ^11 || ^12`, PHP 8.3+.

Defensive by design: permission-gated routes, input reduced to a bare LDH label (`DomainSanitizer` + `DomainValidator`), per-IP rate limiting, allow-list CORS. Depends on core `file`/`options`/`user` and `saudi_id_validator`.

## What it does

Given a bare label (`neixora`), it fans out across every configured TLD in one parallel request and answers **available / registered / unknown** per TLD. Lookup order per TLD, lowest `priority()` first: authoritative HTTP API (off by default) → RDAP → WHOIS → DNS fallback. An unanswerable lookup is `unknown`, never `available` — that is the module's core promise.

## Entry points

- **Search page** — `/domain-search` (perm: `access domain availability search`).
- **JSON API** — `GET /domain-check?domain=<label>` (perm: `use domain availability api`, restricted). Also `GET /domain-check/health`.
- **Block** — *Domain availability search*.
- **Twig** — `{{ domain_availability_search() }}`; render element `#type => domain_availability_search`.
- **PHP** — inject `@domain_availability.checker` → `->check('neixora')` returns a `CheckReport`.
- **Registration requests** — optional intent-collection workflow (see below).

## Architecture (services)

- `domain_availability.checker` (`DomainCheckService`) — orchestrates the sweep, cache, and pricing decoration.
- `domain_availability.provider_registry` — collects `domain_availability_provider`-tagged services; provider `priority()` (lowest first) decides which answers a TLD, not the tag priority.
- Providers: `SaudiNicProvider` (authoritative HTTP API), `RdapProvider`, `WhoisProvider`, `DnsProvider`.
- Lookup plumbing: `ParallelHttpClient` (RDAP, curl_multi-style), `WhoisClient` (raw non-blocking sockets, RFC 3912, port 43), `BoundedDnsResolver` (UDP stub resolver with a deadline — `dns_get_record()` takes no timeout), `HostResolver`, `LookupBudget` (shared wall-clock ceiling).
- Server discovery: `WhoisServerResolver` (shipped map + `whois.iana.org` runtime discovery, cached), `RdapRegistryResolver` (IANA bootstrap `data.iana.org/rdap/dns.json` + fallback map, cached a week).
- `domain_availability.rate_limiter` (`RateLimiter`) — per-IP, by count-in-window and min-interval, backed by expirable key-value + lock.
- Pricing: `PricingManager` + `PricingStrategyRegistry` (`domain_availability_pricing_strategy` tag); `fixed` and `extension` modes ship, one active per `pricing.mode`. Pricing decorates results *after* the lookup cache.

## Extending

- **A provider** = one class implementing `DomainProviderInterface` + one service tagged `domain_availability_provider`. No existing class changes.
- **A pricing strategy** = one class implementing `PricingStrategyInterface` (+ `ConfigurablePricingStrategyInterface` for its own settings fields) + one tagged service; a strategy's `id()` is its `pricing.mode` value.

## Permissions

`access domain availability search`, `use domain availability api` (restricted), `administer domain availability` (restricted), `view domain registration requests` (restricted, holds personal data), `manage domain registration requests` (restricted), `delete domain registration requests` (restricted).

## Registration-request workflow (optional)

Enabled by default for `.sa`. A visitor opens a modal from an available result and submits a request (applicant type, mobile, company documents, national ID validated through `saudi_id_validator`, an optional PDF certificate stored to the private scheme when available). The module records **intent only** — it does not register domains, take payment or contact a registrar. Admin listing, detail page, status workflow (pending/approved/rejected/cancelled) and delete form live under `/admin/config/system/domain-availability/registration-requests`.

## Config

`domain_availability.settings` (TLDs, providers, cache TTL, timeouts, rate limits, CORS origins, pricing) and `domain_availability.registration` (feature toggle, allowed TLDs, upload size/extensions, admin emails, duplicate window). Protocol facts (WHOIS server map, response-pattern lists, RDAP bootstrap URL) live as container parameters in `domain_availability.services.yml`, overridable from `sites/default/services.yml`.

See [../usage.md](../usage.md) for use cases and [agent/changes.md](changes.md) for what 1.2.x changed vs 1.1.x.
