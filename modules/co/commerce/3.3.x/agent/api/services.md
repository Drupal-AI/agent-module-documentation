# Key base services

Selected services from `commerce.services.yml` most useful from custom code.

| Service id | Purpose |
|---|---|
| `commerce.configurable_field_manager` | `ConfigurableFieldManager` — create/delete configurable fields on commerce entity bundles programmatically. |
| `commerce.current_country` | Current customer country (used by pricing/tax/address). |
| `commerce.chain_country_resolver` / `commerce.default_country_resolver` | Chain of country resolvers; add your own resolver service tagged `commerce.country_resolver`. |
| `commerce.current_locale` | Current locale for currency/number formatting. |
| `commerce.chain_locale_resolver` / `commerce.default_locale_resolver` | Locale resolver chain (tag `commerce.locale_resolver`). |
| `commerce.mail_handler` | `MailHandler` — render + send commerce transactional email. |
| `commerce.purchasable_entity_type_repository` | Look up which entity types are purchasable. |
| `plugin.manager.commerce_condition` / `_entity_trait` / `_inline_form` | The three base plugin managers (see [../plugins/plugin-types.md](../plugins/plugin-types.md)). |
| `commerce.credentials_check_flood` | Flood control for gateway credential checks. |
| `commerce.config_updater` | Helper for config updates during upgrades. |

Price formatting is provided through the `commerceguys/intl` library (currency/number
formatters) surfaced via `commerce_price` (see that submodule). Resolver chains use the
decorator/chain pattern: register a service implementing the resolver interface and tag it so
it joins the chain, letting you override country/locale detection.
