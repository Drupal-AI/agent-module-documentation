# commerce_tax — agent start

Commerce submodule: tax calculation via order adjustments. **Tax type** plugins (EU VAT,
Canadian, custom) resolve rates by store registration + customer zone + product tax category.
**Tax number type** plugins validate customer VAT/tax IDs (incl. VIES). Requires `commerce`,
`commerce_price`, `commerce_order`. Admin: **/admin/commerce/config/tax-types**
(`entity.commerce_tax_type.collection`).

- Configure tax types, rates, zones, permissions → [configure/tax.md](configure/tax.md)
- Tax type & tax number type plugins → [plugins/tax-type.md](plugins/tax-type.md)
