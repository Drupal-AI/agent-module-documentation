# Tax configuration

- `commerce_tax_type` (config entity) — an instance of a tax type plugin. Manage at
  `/admin/commerce/config/tax-types` (`entity.commerce_tax_type.collection`).
  - **European Union VAT** / **Canadian** — preconfigured zones & rates.
  - **Custom** — define your own rates and territorial zones in the UI.
- Stores hold **tax registrations** (territories where you collect tax) and a
  prices-include-tax setting; products carry a **tax category** for reduced/zero rates.
- Tax is added to orders as **adjustments** during order refresh, resolved from store
  registration + customer address/zone + product tax category.

## Plugins / managers
- `plugin.manager.commerce_tax_type` (`TaxTypeManager`) — tax type plugins.
- `plugin.manager.commerce_tax_number_type` (`TaxNumberTypeManager`) — validate customer tax
  numbers (EU VAT via VIES, etc.).

## Permissions
`administer commerce_tax_type` (restricted). Config schema:
`config/schema/commerce_tax.schema.yml`. To add a regime, implement a tax type plugin — see
[../plugins/tax-type.md](../plugins/tax-type.md).
