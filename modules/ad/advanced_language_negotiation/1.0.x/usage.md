Provides a Drupal language negotiation method that detects the language from both the request domain and the URL path prefix at the same time.

---

Advanced Language Negotiation adds one negotiation method — "URL (Domain and Path)" — that Drupal core does not offer out of the box: resolving the interface, content and URL language from a combination of the request domain and the path prefix simultaneously. Core's URL negotiation forces a choice between domain-based or prefix-based detection; this module lets a single site map each language to a domain and (optionally) a prefix, so configurations like a UK-English domain, a German domain, and an English-under-the-German-domain prefix all coexist. The plugin `AdvancedLanguageNegotiation` implements core's language-negotiation, inbound/outbound path-processor and language-switcher interfaces, so it strips matched prefixes from inbound paths, rewrites outbound URLs to the right domain and/or prefix, and generates native-name language switch links. Mappings are edited on a dedicated form under Regional and language settings and stored in core's `language.negotiation` config. Enable the method on the standard Language detection and selection page and order it against core's other methods.

---

- Serve US English on example.com and UK English on example.co.uk from one Drupal install.
- Map German to example.de while also serving English under example.de/en via a path prefix.
- Combine country-specific domains with language subdirectories in a single negotiation method.
- Detect the correct language when the same domain hosts multiple languages distinguished by prefix.
- Generate outbound links that automatically point to each language's own domain.
- Add the configured path prefix (for example /en) to generated URLs for prefixed languages.
- Strip the language prefix from inbound request paths so routing matches the internal path.
- Provide a language switcher block whose links carry the current query string and native language names.
- Fall back to the site default language when neither domain nor prefix matches.
- Run domain-and-prefix negotiation for interface language, content language and URL language types at once.
- Configure per-language domain/prefix pairs from one admin form instead of scripting negotiation.
- Support editorial teams that need distinct URLs per market (ccTLD) and per language within a market.
- Preserve the port when generating absolute cross-domain URLs on non-standard ports.
- Respect explicit https/http overrides when rewriting the base URL for a language domain.
- Keep language detection consistent with Drupal's core negotiation ordering and weights.
- Replace a manual mix of core Domain and URL-prefix negotiation with a single coherent method.
- Migrate a multi-domain multilingual site onto Drupal 9/10/11 with combined domain+prefix routing.
- Let marketing use branded ccTLDs (example.fr, example.de) while engineering keeps one codebase.
- Allow safe redirects between the registered language domains rather than only same-host redirects.
- Enable the method per environment and order it above or below core negotiation methods as needed.
