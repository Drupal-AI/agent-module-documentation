# Commerce Currency Resolver Language — agent index

Submodule of **commerce_currency_resolver**. Resolves the *current currency* from the active
interface language via an admin-managed matrix.

- **How resolution works, the mapping config & form, and how to read/set the matrix** →
  [configure/language-mapping.md](configure/language-mapping.md)

Key facts:
- Service `commerce_currency_resolver_language.currency` (`Resolver\CurrencyResolverLanguage`),
  tagged `commerce_price.currency_resolver` **priority 800** (below cookie 1000, geoip/smart_ip 900).
- Config object `commerce_currency_resolver_language.currency_mapping`, key `matrix`
  (`{langcode: currency_code}` sequence). Not shipped in config/install — created on first save.
- `resolve()` = current langcode → `matrix[langcode]` → `CurrencyResolverManager::getCurrencyByCode()`;
  returns NULL (falls through) if unmapped.
- Mapping form: `/admin/commerce/config/commerce_currency_resolver/language`
  (route `commerce_currency_resolver_language.currency_mapping`, permission
  `administer commerce currency resolver settings`).
- No permission/schema of its own beyond the mapping config schema; no plugins; no Drush.
