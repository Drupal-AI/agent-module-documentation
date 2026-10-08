# Commerce Product Tax — agent index

Lets a store pick the applicable **tax rate per product variation**. Adds a
`commerce_tax_rate` field type (+ widget/formatter) whose settings bind it to a Commerce
**tax type** and its zones, plus a **tax-rate resolver** that applies the chosen rate at
order time. No settings page (`configure: null`) — configuration *is* the field on the
variation type. Depends on `commerce_tax`.

- **Add the "Tax rate" field to a variation type, its settings (`tax_type`,
  `allowed_zones`), widget, and the stored value format** →
  [configure/tax-rate-field.md](configure/tax-rate-field.md)
- **How the tax rate is resolved at order time (the resolver + value format)** →
  [api/resolver.md](api/resolver.md)

Key facts:
- Field type `commerce_tax_rate` — settings `tax_type` (a Local tax type id, e.g. a
  `european_union_vat` tax type) and `allowed_zones` (list of that tax type's zone ids).
  Default widget `commerce_tax_rate_default` (select), default formatter `string` (also
  `commerce_tax_rate_percentage`).
- Stored value = `"<zone_id>|<rate_id>"` (or `"<zone_id>|" . NO_APPLICABLE_TAX_RATE` for
  "No tax").
- Resolver `Drupal\commerce_product_tax\Resolver\TaxRateResolver` is tagged
  `commerce_tax.tax_rate_resolver` at **priority 100**; it reads the variation's
  `commerce_tax_rate` field and returns the matching rate for the current zone.
- Provides config schema (`field.value.commerce_tax_rate`,
  `field.field_settings.commerce_tax_rate`); no permissions, no Drush, no plugin types.
