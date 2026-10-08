<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The four Commerce events

All of them are queued through the parent module's service
`facebook_pixel.facebook_event` (`addEvent()`), so they pass through
`hook_facebook_pixel_event_data_alter()` and end up in
`drupalSettings.facebook_pixel.events`.

## `ViewContent` — `facebook_pixel_commerce_commerce_product_view()`

Fires for a `commerce_product` rendered in the **`full`** view mode.

```php
[
  'content_type' => count($skus) > 1 ? 'product_group' : 'product',
  'content_name' => $product->getTitle(),
  'content_ids'  => [/* every variation SKU */],
  'contents'     => [
    ['id' => $sku, 'value' => $roundedPrice, 'quantity' => 1],
    // one per variation
  ],
  // appended only when the product has a default variation:
  'value'    => $roundedDefaultPrice,   // string, '0' when there is no price
  'currency' => $currencyCode,
]
```

Prices go through `commerce_price.rounder` and `getNumber()`, so `value` is always a
**string**.

## `AddToCart` — `CartSubscriber::addToCart()`

Subscribed to `CartEvents::CART_ENTITY_ADD`. Payload is
`FacebookCommerce::getOrderItemData($event->getOrderItem())` and it is queued with
`addEvent('AddToCart', $data, TRUE)` — the third argument **forces a session** so the event
survives the post-add redirect.

```php
[
  'value'        => $roundedUnitPrice,   // string
  'currency'     => $currencyCode,
  'order_id'     => $orderItem->getOrderId(),
  'content_ids'  => [$sku ?? $purchasedEntityId ?? ''],
  'content_name' => $orderItem->getTitle(),
  'content_type' => 'product',
  'contents'     => [['id' => $sku ?? $purchasedEntityId ?? '', 'quantity' => $qty]],
]
```

The SKU is taken only when the purchased entity is a `ProductVariationInterface`.

## `InitiateCheckout` — `FacebookCheckout` checkout pane

Plugin `facebook_checkout` (`@CommerceCheckoutPane`, `default_step = "order_information"`).
`buildPaneForm()` returns an empty form array and, **only when the request is not an
XmlHttpRequest**, queues `addEvent('InitiateCheckout', $this->facebookComment->getOrderData($this->order))`.
The XHR guard exists because the pane form is rebuilt on every Ajax refresh
(drupal.org issue 3246045).

The pane must be placed in the checkout flow — see
[../configure/checkout-pane.md](../configure/checkout-pane.md).

## `Purchase` — `CartSubscriber::purchase()`

Subscribed to `commerce_order.place.post_transition` (a `state_machine`
`WorkflowTransitionEvent`). Payload is `FacebookCommerce::getOrderData($order)`.

## `FacebookCommerce::getOrderData()`

Service `facebook_pixel_commerce.facebook_commerce`
(`FacebookCommerceInterface`), constructed with `commerce_price.rounder`.

```php
[
  'value'        => $roundedOrderTotal,   // string, '0' when the order has no total
  'currency'     => $currencyCode,        // '' when there is no total
  'num_items'    => count($order->getItems()),
  'content_name' => 'order',
  'content_type' => 'product',
  // only when at least one item produced data:
  'contents'     => [['id' => $sku, 'quantity' => $qty], …],
  'content_ids'  => [$sku, …],
]
```

Both methods return `[]` for a NULL / wrong-type argument, and `CartSubscriber` skips the
event when the array is empty.

## Calling it yourself

```php
$fbc = \Drupal::service('facebook_pixel_commerce.facebook_commerce');
$data = $fbc->getOrderData($order);            // or ->getOrderItemData($order_item)
\Drupal::service('facebook_pixel.facebook_event')->addEvent('Purchase', $data);
```

## Rewriting the payload

The canonical example in `facebook_pixel.api.php` targets exactly this submodule:

```php
function my_module_facebook_pixel_event_data_alter(array &$data, $event) {
  if ($event === 'ViewContent') {
    /** @var \Drupal\commerce_product\Entity\Product $entity */
    $entity = \Drupal::request()->get('_entity');
    $data['content_ids'][0] = $entity->id();     // product id instead of SKU
  }
}
```

See the parent's [hooks doc](../../../../2.0.x/agent/hooks/event-data-alter.md).
