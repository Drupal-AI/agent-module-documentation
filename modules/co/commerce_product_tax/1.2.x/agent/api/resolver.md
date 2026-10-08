# How the tax rate is resolved (the resolver)

Commerce resolves tax in two stages: pick the **tax type(s)** for an order item, then for
each type's matching **zone** pick a **rate**. Commerce Product Tax plugs into the second
stage.

## The tagged resolver

`commerce_product_tax.services.yml` registers:

```yaml
commerce_product_tax.tax_rate_resolver:
  class: Drupal\commerce_product_tax\Resolver\TaxRateResolver
  tags:
    - { name: commerce_tax.tax_rate_resolver, priority: 100 }
```

Priority 100 makes it run **before** Commerce's default rate resolver, so an editor-chosen
rate wins.

## What `TaxRateResolver::resolve()` does

Signature: `resolve(TaxZone $zone, OrderItemInterface $order_item, ProfileInterface $customer_profile)`.

1. Gets the order item's purchased entity (the product variation).
2. Finds its fields of type `commerce_tax_rate` (`getTaxFieldNames()`).
3. For each such non-empty field:
   - Skips it unless the field's **`tax_type`** setting equals the tax type currently being
     resolved (`$this->taxType->id()`), so a field only answers for its own tax type.
   - Splits the stored value `"<zone_id>|<rate_id>"`.
   - Skips if `zone_id` != the current `$zone` id.
   - If `rate_id` is the `NO_APPLICABLE_TAX_RATE` marker → returns that marker (**no tax**).
   - Otherwise returns the `TaxRate` object from the zone whose id matches `rate_id`.
4. Returns `NULL` if nothing matched (Commerce then falls back to lower-priority resolvers).

The resolver uses `TaxTypeAwareTrait` (`$this->taxType`) — Commerce sets the current tax type
on it before calling `resolve()`.

## Value format recap

| Stored `value` | Meaning |
|---|---|
| `de\|standard` | Germany zone, rate id `standard` |
| `fr\|reduced` | France zone, reduced rate |
| `de\|` + `NO_APPLICABLE_TAX_RATE` | "No tax" for the Germany zone |
| empty | field is empty → resolver ignores it |

## Related plugins the module provides
- Field type `commerce_tax_rate` (`TaxRateItem` / `TaxRateItemList`).
- Widget `commerce_tax_rate_default` (`TaxRateDefaultWidget`, a select).
- Formatter `commerce_tax_rate_percentage` (`TaxRatePercentageFormatter`); also enables core
  `string` on the field via `hook_field_formatter_info_alter()`.
- Validation `TaxRateConstraint` / `TaxRateConstraintValidator`.

These are plugin *instances*, not new plugin types — there is no plugin manager to implement
against, so there is no `plugins` doc.
