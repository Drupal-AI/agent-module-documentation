Country Path extends the Domain module so a single hostname can serve several "countries" distinguished by a first URL path segment (e.g. `example.com/usa`, `example.com/fra`) instead of needing a separate subdomain per country. It negotiates the active domain from that path prefix and rewrites inbound/outbound URLs to add or strip it.

---

The module overrides the Domain entity, its forms, and its list builder so each domain record can store a `domain_path` third-party setting (the country prefix). You enter it on the domain add/edit form by appending it to the canonical hostname (`example.com/usa`); an entity builder splits it back out and saves it as `country_path.domain_path`. A `hook_domain_request_alter` implementation inspects the request path's first segment and matches it (optionally via a `domain_alias` such as `example.com/usa`) to the domain whose `domain_path` equals that prefix, falling back to the default domain when the prefix is empty or unknown. An inbound/outbound path processor (`CountryPathProcessor`, high inbound priority 400) strips the prefix from incoming paths and re-adds it as a URL `prefix` option on generated links, and a `url.country` cache context keyed on the active domain id keeps render caching correct per country. When the core `language` module is present, the module registers a `country-path-language-url` language negotiation plugin (a subclass of core's URL negotiator) at weight `-1`/`-8` so language can be detected from either the path prefix or the domain, and wires it in automatically on install / language-module install. It also overrides the `domain_alias.validator` and the Domain entity `preSave` (to relax the unique-hostname check so `example.com/usa` and `example.com/fra` can coexist). There is no global settings page (`configure` is null); all configuration is per-domain plus the language negotiation UI.

---

- Serve several country sites from one domain using path prefixes (`example.com/usa`, `example.com/de`).
- Avoid buying/configuring a separate subdomain or TLD per country while still using Domain.
- Detect the active domain from the first URL segment on every request.
- Give each Domain record a country path prefix on the domain edit form.
- Route `example.com/usa/...` requests to the "USA" domain automatically.
- Fall back to the default domain when no country prefix is present in the URL.
- Match a country prefix through a `domain_alias` pattern like `example.com/usa`.
- Support alias redirects so an old country URL forwards to the canonical one.
- Strip the country prefix from internal paths so routing/controllers see clean paths.
- Automatically prepend the country prefix to all generated links for the active domain.
- Combine country prefix and language prefix in one URL (`example.com/usa/fr/...`).
- Detect interface/content language from the country path prefix via the bundled negotiator.
- Detect language from the domain hostname when configured with per-language domains.
- Keep page cache correct per country using the `url.country` cache context.
- Let two domains share the same hostname but different country paths (relaxed unique-hostname check).
- Build a multi-country marketing site with per-country content under one domain.
- Migrate a subdomain-per-country setup to a single-domain path-prefix scheme.
- Expose the country path in sitemaps/URLs consistently for SEO per country.
- Let editors set a country's prefix without touching code or config files.
- Remove a country restriction by clearing the domain's path value on the form.
- Ensure Simple Sitemap and similar tools discover the country-path URL language negotiator.
- Provide country-scoped URLs for a decoupled/front-end consumer via outbound URL rewriting.
