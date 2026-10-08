# Tax plugins

## commerce_tax.tax_type — a tax regime
- Manager: `plugin.manager.commerce_tax_type` (`Drupal\commerce_tax\TaxTypeManager`).
- Attribute: `#[CommerceTaxType]`; base class
  `Drupal\commerce_tax\Plugin\Commerce\TaxType\TaxTypeBase` (and `LocalTaxTypeBase` for
  rate/zone-driven types). Place in `src/Plugin/Commerce/TaxType/`.
- Key methods: `applies(OrderInterface $order)` and `apply(OrderInterface $order)` — decide
  applicability and add tax **adjustments** to order items; `getZones()` returns the
  territorial zones with their tax rates. Built-ins: `european_union_vat`, `canadian_sales_tax`,
  `custom`.

## commerce_tax.tax_number_type — validate a tax ID
- Manager: `plugin.manager.commerce_tax_number_type` (`TaxNumberTypeManager`).
- Attribute: `#[CommerceTaxNumberType]`; validates and (optionally) verifies customer tax
  numbers, e.g. EU VAT numbers against the VIES service, for B2B/reverse-charge handling.

To support a new country's tax, extend `LocalTaxTypeBase` (or `TaxTypeBase`) defining its
zones/rates and applicability, then create a `commerce_tax_type` config entity using it.
