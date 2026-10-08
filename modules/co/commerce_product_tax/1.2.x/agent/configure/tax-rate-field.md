# Add and configure the "Tax rate" field on a product variation type

The module has **no settings page**. You configure it by attaching a `commerce_tax_rate`
field to a product variation type and setting which tax type / zones it uses.

## Prerequisite: a Local tax type

The field's rates come from a Commerce **tax type** whose plugin implements
`LocalTaxTypeInterface` (e.g. a `european_union_vat` tax type, or a Custom local tax type).
Create one at *Commerce → Configuration → Tax types* (`commerce_tax_type` config entities) if
none exists. Only Local tax types appear in the field settings.

## Add the field

### Via the UI
1. *Commerce → Configuration → Product variation types → (type) → Manage fields*.
2. **Add field → Tax rate** (the `commerce_tax_rate` field type). Save.
3. In field settings choose the **Tax type** and the **Allowed zones** (multi-select of that
   tax type's zones). Save.
4. On *Manage form display* the field uses the **Default** widget
   (`commerce_tax_rate_default`, a select of the zones' rates + a "No tax" option).

### Field settings (schema `field.field_settings.commerce_tax_rate`)
```yaml
tax_type: cpt_eu_vat        # id of a Local tax type (LocalTaxTypeInterface)
allowed_zones:              # which of that tax type's zones the editor may choose from
  - de
  - fr
```

### Via drush php:eval (scriptable)
```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

FieldStorageConfig::create([
  'field_name' => 'field_tax_rate',
  'entity_type' => 'commerce_product_variation',
  'type' => 'commerce_tax_rate',
])->save();

FieldConfig::create([
  'field_name' => 'field_tax_rate',
  'entity_type' => 'commerce_product_variation',
  'bundle' => 'default',                 // the variation type
  'label' => 'Tax rate',
  'settings' => [
    'tax_type' => 'cpt_eu_vat',          // a Local tax type id
    'allowed_zones' => ['de', 'fr'],     // zone ids of that tax type
  ],
])->save();
```

### Read it back
```bash
drush cget field.field.commerce_product_variation.default.field_tax_rate settings
# settings.tax_type: cpt_eu_vat ; settings.allowed_zones: [de, fr]
```

## The widget and stored value

- Widget `commerce_tax_rate_default` (extends `OptionsSelectWidget`) groups options by zone
  label and lists each rate as e.g. `Standard (20%)`, plus a **No tax** option per zone.
- The selected value is stored as a single string **`"<zone_id>|<rate_id>"`** (column
  `value`, varchar 64). "No tax" stores `"<zone_id>|" . TaxRateResolverInterface::NO_APPLICABLE_TAX_RATE`.
- Formatters: default `string`; `commerce_tax_rate_percentage` renders the rate's percentage.

## What happens at order time
See [api/resolver.md](../api/resolver.md): the module's tax-rate resolver reads this field and
supplies the chosen rate to Commerce's tax calculation.
