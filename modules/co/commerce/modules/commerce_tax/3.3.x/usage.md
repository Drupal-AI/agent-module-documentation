Commerce Tax adds automatic tax calculation to orders through configurable tax types (EU VAT, Canadian GST, US sales tax, custom) with rates, zones and jurisdictions.

---

Tax is applied as order **adjustments** computed at order refresh time. A **tax type** (`commerce_tax.tax_type`) encapsulates a whole tax regime: built-in plugins cover European Union VAT and Canadian taxes with their zones and rates preconfigured, a **custom** tax type lets you define your own rates and territorial zones, and you can write new tax type plugins. Each tax type resolves the applicable **tax rate** for an order item based on the store's tax registrations, the customer's address/zone and the product's tax category, then adds an included or added adjustment. It supports tax-inclusive vs. tax-exclusive pricing, display-inclusive prices, rounding, and per-product tax categories. A second plugin type, **tax number type** (`commerce_tax.tax_number_type`), validates customer tax numbers (e.g. EU VAT ID, including VIES verification) for B2B/reverse-charge scenarios. It depends on Commerce, Price and Order. Manage tax types at Admin → Commerce → Configuration → Tax types (`entity.commerce_tax_type.collection`).

---

- Automatically calculate tax on orders and show it at checkout.
- Apply EU VAT with correct per-country rates and zones.
- Apply Canadian GST/HST/PST.
- Configure US sales tax rates per jurisdiction.
- Define a custom tax type with your own rates and zones.
- Support tax-inclusive (VAT) or tax-exclusive (US) pricing.
- Display prices with tax included in the storefront.
- Assign tax categories to products (e.g. reduced-rate goods).
- Resolve the correct rate from the customer's address.
- Add tax as a first-class order adjustment.
- Handle B2B reverse charge with validated VAT numbers.
- Validate EU VAT IDs (including VIES online checks).
- Store a store's tax registrations/territories.
- Round tax amounts per currency rules.
- Exempt certain customers or zones from tax.
- Show a tax breakdown on the order summary.
- Recalculate tax when the shipping/billing address changes.
- Support multiple tax types on a multi-region store.
- Implement a custom tax type plugin for a specific country.
- Implement a custom tax number type for a national scheme.
- Keep tax config exportable as configuration.
