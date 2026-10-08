# Coupon condition evaluation & programmatic API

Class `Drupal\commerce_coupon_conditions\Entity\Coupon` (in `src/Entity/Coupon.php`) replaces the
core `commerce_promotion_coupon` entity class and adds a per-coupon condition set. Interface:
`Drupal\commerce_coupon_conditions\Entity\CouponInterface` (extends the core
`\Drupal\commerce_promotion\Entity\CouponInterface`).

## How a coupon gates the discount

Commerce calls `Coupon::available(OrderInterface $order)` while resolving whether a redeemed coupon
may apply to an order. This override:

```php
public function available(OrderInterface $order) {
  $available = parent::available($order);   // core checks: enabled, usage limits, per-customer limit
  if ($available) {
    return $this->applies($order);          // AND this module's own condition check
  }
  return FALSE;
}
```

`applies()` does the actual condition evaluation:

```php
public function applies(OrderInterface $order) {
  $conditions = $this->getConditions();
  if (!$conditions) {
    return TRUE;                             // no conditions => coupon always applies
  }
  // Keep only order-scoped conditions.
  $conditions = array_filter($conditions, function ($condition) {
    return $condition->getEntityTypeId() == 'commerce_order';
  });
  $condition_group = new ConditionGroup($conditions, $this->getConditionOperator());
  return $condition_group->evaluate($order);
}
```

Key behavioral points:

- This override is **purely additive/restrictive**: it can only turn an already-available coupon
  OFF (returns `FALSE` when conditions fail); it never makes an unavailable coupon available. A
  coupon with no conditions behaves exactly like a core coupon.
- Evaluation is **server-side against the live `OrderInterface` object** passed by Commerce
  (`ConditionGroup::evaluate($order)`); the coupon reads no client-supplied value. The conditions
  themselves are Commerce core's own `commerce_condition` plugins.
- The operator (`AND`/`OR`) comes from the coupon's `condition_operator` field. `AND` = every
  condition must pass; `OR` = at least one must pass.
- Conditions are filtered to `getEntityTypeId() == 'commerce_order'` (order/cart conditions);
  order-item-scoped conditions are dropped here.

## Programmatic API

`getTargetInstance()` on each field item yields the condition plugin; parent-aware conditions get
the coupon set as their parent entity.

| Method | Returns | Notes |
| --- | --- | --- |
| `getConditions()` | `ConditionInterface[]` | Instantiates each stored plugin; calls `setParentEntity($this)` on any `ParentEntityAwareInterface` condition. |
| `setConditions(array $conditions)` | `$this` | Accepts `ConditionInterface` objects; stores each as `target_plugin_id` + `target_plugin_configuration`. Non-`ConditionInterface` items are ignored. |
| `getConditionOperator()` | `string` | Value of the `condition_operator` field (`AND`/`OR`). |
| `setConditionOperator($operator)` | `$this` | Sets the `condition_operator` field. |
| `applies(OrderInterface $order)` | `bool` | Condition-group result (see above). |
| `available(OrderInterface $order)` | `bool` | `parent::available()` AND `applies()`. |

Example — attach an order-total condition to a coupon in code:

```php
/** @var \Drupal\commerce_coupon_conditions\Entity\CouponInterface $coupon */
$coupon = \Drupal::entityTypeManager()->getStorage('commerce_promotion_coupon')->load($id);
$condition = \Drupal::service('plugin.manager.commerce_condition')
  ->createInstance('order_total_price', [
    'operator' => '>',
    'amount' => ['number' => '100.00', 'currency_code' => 'USD'],
  ]);
$coupon->setConditions([$condition])->setConditionOperator('AND')->save();
```

Condition plugin ids (`order_total_price`, `order_customer_role`, `order_email`, etc.) come from
Commerce / commerce_order / commerce_promotion — this module defines none of its own.
