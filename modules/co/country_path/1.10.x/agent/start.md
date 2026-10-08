# Country Path — agent index

Extends **Domain** so one hostname serves multiple countries by a first URL path segment
(`example.com/usa`). Detects the active domain from that prefix and rewrites URLs to add/strip it.
Depends on `domain`. No global settings page (`configure` null), no permissions, no Drush. Provides a
config schema (the `country_path.domain_path` third-party setting) and a language negotiation plugin.

- **Set a country's prefix on a domain, aliases, and enable/order the language negotiator** →
  [configure/setup.md](configure/setup.md)
- **Internals: domain-request alter, path processor, cache context, entity/form/validator overrides** →
  [api/internals.md](api/internals.md)

Key facts:
- Prefix stored as domain third-party setting `country_path.domain_path` (schema
  `domain.record.*.third_party.country_path`).
- Active-domain detection: `country_path_domain_request_alter()` in `country_path.module` matches URL
  segment 1 to the domain whose `domain_path` equals it (or a `domain_alias` hostname `host/prefix`).
- URL rewriting: `src/HttpKernel/CountryPathProcessor.php` (inbound priority 400, outbound 10);
  cache context `url.country` = active domain id.
- Language: `country-path-language-url` negotiation plugin
  (`src/Plugin/LanguageNegotiation/LanguageNegotiationCountryPathUrl.php`), auto-enabled at weight -1 when
  `language` is installed.
