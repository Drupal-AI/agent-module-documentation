# Admin configuration hub

The base module provides the **Commerce → Configuration** hub, not a single settings form.
Route `commerce.configuration` → `/admin/commerce/config` (a system overview page, perm
`access commerce administration pages`). Sub-hubs are added by submodules, e.g.
`/admin/commerce/config/store`, `/admin/commerce/config/currencies`,
`/admin/commerce/config/order-types`, checkout flows, tax types, payment gateways, etc.

Base-module config surfaces:
- **Partner banners** — some Commerce admin pages show technology-partner offers. Disable by
  setting `$settings['commerce_partner_banners'] = FALSE;` in `settings.php`.
- Currency/number formatting and country/locale behavior come from base services (see
  [../api/services.md](../api/services.md)) rather than a config form.

Most day-to-day configuration (stores, product types, order types, checkout flows, payment
gateways, tax types, promotions) lives in the respective submodule — start from its own
docs. Config schema for the base module is in `config/schema/commerce.schema.yml`.
