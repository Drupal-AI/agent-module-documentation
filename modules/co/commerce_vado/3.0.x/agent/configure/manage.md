# Configure — /admin/commerce/config/vado

Route `commerce_vado.manage` → `\Drupal\commerce_vado\Form\VadoManagementForm` (a `ConfigFormBase`),
permission `access vado administration pages`. Linked in the admin menu under
Commerce › Configuration › Products (`commerce_vado.manage` menu link). This single form does two jobs:

## 1. Enable/disable the add-on fields per product variation type

The form lists every `commerce_product_variation_type` with a checkbox per VADO field. Checking a box
**creates** the field (config + default form-display component) on that variation type; **unchecking and
saving deletes the field and all its data** (the form shows this warning). Field definitions come from
`VadoFieldManager::getVadoFields()`; storages ship in `config/install/field.storage.commerce_product_variation.*.yml`.

| Field | Storage type | Card. | Default widget | Purpose |
|---|---|---|---|---|
| `child_variations` | entity_reference → `commerce_product_variation` | -1 | entity_reference_autocomplete | Add-on variations auto-added to cart with the parent. **Primary.** |
| `variation_groups` | entity_reference → `commerce_vado_group` | -1 | entity_reference_autocomplete | Reusable add-on groups rendered as widgets on the Add to Cart form. **Primary.** |
| `sync_quantity` | boolean | 1 | boolean_checkbox | Lock each child's cart quantity to the parent quantity (bundle). |
| `bundle_discount` | integer (percentage, max 100) | 1 | number | % discount applied to the children (and parent if `include_parent`). |
| `include_parent` | boolean | 1 | boolean_checkbox | Also discount the parent variation by `bundle_discount`. |
| `exclude_parent` | boolean | 1 | boolean_checkbox | Drop the parent from the order; only children are added (disables sync/include/discount for that parent). |

Notes verified from source:
- A variation type is "VADO-enabled" if it has either **primary** field (`child_variations` or
  `variation_groups`) — `VadoFieldManager::isVadoEnabled()`. `sync_quantity`/`bundle_discount`/
  `include_parent`/`exclude_parent` are only visible in the form once a primary field is checked (`#states`)
  and are force-disabled on submit if no primary field is enabled (`validateForm()`).
- A primary field checkbox is **disabled** (cannot be unchecked) while any variation of that type has data
  in it — `shouldDisableFieldCheckbox()` → `hasFieldData()`. This prevents accidental data loss.
- `bundle_discount` originally had a `min` restriction; `commerce_vado_update_8201()` removed it, so a
  negative value (a markup) is possible. Multiplier is `(100 - value) / 100`.
- To make the calculated-price formatter reflect VADO discounts on the variation display, the variation's
  `price` field must use the `commerce_price_calculated` formatter with the `vado_discount` adjustment type
  enabled (`commerce_vado_update_8202()` migrates existing displays).

## 2. Module settings — config object `commerce_vado.settings`

Schema `config/schema/commerce_vado.schema.yml` (`commerce_vado.settings` is a `config_object`):

| Key | Meaning | Effect |
|---|---|---|
| `hide_parent_zero_price` | Hide the parent variation's price in cart/order Views when it is zero. | Read in `commerce_vado_preprocess_views_view_field()`; blanks `unit_price__number` / `total_price__number` for VADO parent order items whose price is zero. Requires a cache clear (the form warns via AJAX). |
| `allow_unpublished_variations` | Allow **unpublished** child/group variations to be added to orders and priced. | When off (default), unpublished add-on variations are skipped everywhere (cart event, order processor, group widget option lists, cache tags). |

Set via Drush / PHP:

```bash
drush cset commerce_vado.settings hide_parent_zero_price 1 -y
drush cset commerce_vado.settings allow_unpublished_variations 0 -y
drush cr   # required for hide_parent_zero_price to take effect
```

```php
\Drupal::configFactory()->getEditable('commerce_vado.settings')
  ->set('hide_parent_zero_price', TRUE)
  ->set('allow_unpublished_variations', FALSE)
  ->save();
```

Enabling fields programmatically (instead of the UI):

```php
/** @var \Drupal\commerce_vado\VadoFieldManagerInterface $fm */
$fm = \Drupal::service('commerce_vado.field_manager');
// keys are vado field names, values booleans (TRUE = install, FALSE = delete)
$fm->updateFields([
  'child_variations' => TRUE,
  'sync_quantity'    => TRUE,
  'bundle_discount'  => TRUE,
], 'my_parent_variation_type');
```
