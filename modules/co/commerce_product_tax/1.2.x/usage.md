Commerce Product Tax lets you pick the applicable tax rate per product variation: it adds a "Tax rate" field type (`commerce_tax_rate`) whose widget lists the rates of a chosen Commerce tax type, and a tax-rate resolver that applies the selected rate at order time.

---

The module extends Drupal Commerce's tax system so that, instead of relying purely on automatic rate resolution, a store can **manually choose which tax rate applies to each product variation**. It provides a `commerce_tax_rate` field type (default widget `commerce_tax_rate_default`, a select list; default formatter `string`, plus a `commerce_tax_rate_percentage` formatter), with two field settings: **`tax_type`** (a Local tax type such as European Union VAT) and **`allowed_zones`** (which of that tax type's zones the editor may pick from). You attach this field to a product variation type; on the variation form the widget shows the zones' rates (e.g. "Standard (20%)") plus a "No tax" option, and stores the chosen value as `zone_id|rate_id` (or `zone_id|` + the "no applicable tax" marker). At checkout, the module's `TaxRateResolver` — registered as a `commerce_tax.tax_rate_resolver` with priority 100 — reads the value from the variation's `commerce_tax_rate` field(s), matches it to the current tax zone, and returns that rate to Commerce's tax calculation (overriding the default resolver). It also registers a `TaxRateConstraint` validator and marks the `string` formatter as usable on the field. There is no settings page (`configure: null`); all configuration is the field itself on the variation type. Depends on `commerce_tax`.

---

- Manually set the VAT rate on each product variation instead of relying on automatic rules.
- Sell a reduced-rate product (e.g. books, food) by choosing its reduced rate on the variation.
- Mark specific variations as zero-rated / "No tax" while others use the standard rate.
- Restrict the selectable rates to a subset of a tax type's zones via `allowed_zones`.
- Bind a variation's tax field to the European Union VAT tax type and pick a country's rate.
- Give store staff a simple dropdown of named rates ("Standard (20%)") on the variation form.
- Model products whose tax rate differs by category by setting each variation's rate.
- Override Commerce's default tax-rate resolution with an editor-chosen rate per product.
- Apply a custom Local tax type's rates to variations through the tax-rate field.
- Display a variation's configured tax rate on the product page (string / percentage formatter).
- Ensure the correct rate is used at checkout by having the resolver read the variation field.
- Add a "Tax rate" field to a physical-product variation type in a Commerce store.
- Let a multi-rate catalog assign per-item rates without writing tax resolver code.
- Configure which tax type governs a variation type's rates (field `tax_type` setting).
- Keep tax choices with the product data (on the variation) rather than in global tax rules.
- Support stores that must hand-pick rates for regulatory reasons.
- Migrate a legacy per-product tax setup into Commerce's tax system via this field.
- Validate stored rate values against the tax type with the bundled TaxRateConstraint.
- Offer a "No tax" choice explicitly on the variation for exempt items.
- Combine automatic tax zones with a manual rate pick per variation.
- Provide different rates per zone by selecting the zone-qualified rate on the variation.
- Show the tax rate percentage on the storefront using the commerce_tax_rate_percentage formatter.
