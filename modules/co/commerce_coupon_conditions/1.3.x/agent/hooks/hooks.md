# Hooks (implemented & invoked)

## Implemented (`commerce_coupon_conditions.module`)

| Hook | Effect |
| --- | --- |
| `hook_entity_type_alter` | Swaps the class of entity type `commerce_promotion_coupon` to `Drupal\commerce_coupon_conditions\Entity\Coupon`. This is how the per-coupon condition fields and `available()`/`applies()` override take effect. |
| `hook_help` | On `help.page.commerce_coupon_conditions`, reads bundled `README.md`; renders it through the `markdown` filter if the `markdown` module is enabled, else wraps it in `<pre>`. |

## Implemented (`commerce_coupon_conditions.install`)

| Hook | Effect |
| --- | --- |
| `hook_install` | Installs the `conditions` and `condition_operator` field storage definitions on `commerce_promotion_coupon` via `entityDefinitionUpdateManager`. |
| `hook_uninstall` | Removes those two field storage definitions. |
| `hook_update_8101` (`commerce_coupon_conditions_update_8101`) | Batch update: normalises coupon `start_date`/`end_date` values stored as bare `YYYY-MM-DD` to the full `DATETIME_STORAGE_FORMAT`. Start dates get time `00:00:00`, end dates `23:59:59` (site default timezone). Processes 100 coupons per batch, queried with `accessCheck(FALSE)`. Skip entirely by setting `$settings['commerce_coupon_condition_skip_update_8101'] = TRUE;` in `settings.php`. |

## Invoked for integrators

`commerce_coupon_conditions_update_8101` invokes an alter hook so other modules can override the
time-setting callbacks used during that update:

```php
// Implements hook_commerce_coupon_conditions_update_8101_alter().
function MYMODULE_commerce_coupon_conditions_update_8101_alter(array &$target_fields) {
  // $target_fields = ['start_date' => callable, 'end_date' => callable];
  // Each callable receives a \DateTime by reference and returns bool (TRUE = save).
  $target_fields['end_date'] = 'my_custom_set_end_date_time';
}
```

The update validates that both `start_date` and `end_date` keys survive the alter and that each
mapped function exists (`function_exists`), throwing `UpdateException` otherwise. Default callbacks:
`_commerce_coupon_conditions_set_start_date_time()` (00:00:00) and
`_commerce_coupon_conditions_set_end_date_time()` (23:59:59).
