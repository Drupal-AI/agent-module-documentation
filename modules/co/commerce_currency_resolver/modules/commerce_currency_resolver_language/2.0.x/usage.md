Submodule of Commerce Currency Resolver that picks the shopper's currency from the current interface language, using an admin-managed language → currency mapping.

---

The submodule registers a `commerce_price.currency_resolver` service (`CurrencyResolverLanguage`, priority 800) that reads the current language id from the language manager and looks it up in the `commerce_currency_resolver_language.currency_mapping` config object's `matrix` (a `language_id => currency_code` map). If a currency is mapped for the active language it returns that currency entity; otherwise it returns NULL and the resolver chain falls through to the next resolver (or the store default). A mapping form at `/admin/commerce/config/commerce_currency_resolver/language` (route `commerce_currency_resolver_language.currency_mapping`, permission `administer commerce currency resolver settings`) shows one radio group per site language listing the active currencies. Because language is the lowest-priority core-shipped resolver here (cookie 1000 and geoip/smart_ip 900 outrank it), it acts as a sensible default when no stronger signal is present. Ideal for multilingual Commerce stores where each language should default to a matching currency.

---

- Default a store's currency from the visitor's interface language (e.g. `de` → EUR, `en` → USD).
- Give each configured site language its own currency without writing code.
- Provide a baseline currency that applies when no cookie or geolocation is set.
- Map several languages to the same currency (all English variants → USD).
- Combine with the cookie submodule so an explicit choice overrides the language default.
- Combine with geoip/smart_ip so country beats language but language still catches the rest.
- Localise a multilingual storefront so prices show in the expected currency per language.
- Read back the current language→currency mapping from `commerce_currency_resolver_language.currency_mapping:matrix`.
- Change one language's mapped currency via the admin form or drush config.
- Clear a language mapping so that language falls through to the store default.
- Seed language→currency mappings in a config export / recipe.
- Support a site where switching language should switch prices automatically.
- Drive currency selection purely from Drupal's own language negotiation (path prefix, domain, session).
- Keep currency consistent with translated content on multilingual product pages.
- Add a new language and immediately assign it a currency in the matrix.
- Verify which currency a given language resolves to when debugging price display.
- Use as the fallback layer beneath higher-priority resolvers in the currency chain.
- Avoid per-store duplication by resolving currency from language instead of separate stores.
