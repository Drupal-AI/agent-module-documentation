# commerce — agent start

Base module of Drupal Commerce: shared framework for the storefront submodules. Defines
conditions, entity traits and inline-form plugin types; provides currency/price formatting,
country/locale resolvers, configurable-field manager and a mail handler. Admin hub:
**/admin/commerce/config** (route `commerce.configuration`, perm
`access commerce administration pages`). Depends on Address, Entity, Entity Reference
Revisions, Inline Entity Form, Profile, State Machine, Token, core Views/Datetime.

Submodules (documented separately): store, product, order, cart, checkout, payment, price,
tax, promotion. (Not separately documented: commerce_log, commerce_number_pattern,
commerce_payment_example.)

- Admin config hub & base settings → [configure/config.md](configure/config.md)
- Plugin types it defines (condition, entity_trait, inline_form) → [plugins/plugin-types.md](plugins/plugin-types.md)
- Key base services (price formatter, resolvers, field manager) → [api/services.md](api/services.md)
- Hooks (`commerce.api.php`) → [hooks/hooks.md](hooks/hooks.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
