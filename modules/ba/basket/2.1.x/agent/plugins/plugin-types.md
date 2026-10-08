# Plugin types

Basket defines **8 annotation-based plugin types**, each with a manager service (a
`DefaultPluginManager` subclass, `parent: default_plugin_manager` in `basket.services.yml`) that
discovers plugins under `src/Plugin/Basket/<Type>/` in any module and supports an alter hook + cache.
This is how ecosystem add-ons (delivery/payment providers, discount rules) plug in — the core module
ships the *types* and a few example plugins; **no payment gateway ships in core** (payment providers
are separate projects).

| Type | Manager service | Annotation | Interface | Discovery dir | Alter |
|---|---|---|---|---|---|
| Payment gateway | `BasketPayment` | `@BasketPayment` | `Plugins\Payment\BasketPaymentInterface` | `Plugin/Basket/Payment` | `basket_payment_info` |
| Delivery method | `BasketDelivery` | `@BasketDelivery` | `Plugins\Delivery\BasketDeliveryInterface` | `Plugin/Basket/Delivery` | (manager default) |
| Delivery settings | `BasketDeliverySettings` | `@BasketDeliverySettings` (`parent_field`) | `BasketDeliverySettingsInterface` | `Plugin/Basket/DeliverySettings` | — |
| Discount rule | `BasketDiscount` | `@BasketDiscount` | `Plugins\Discount\BasketDiscountInterface` | `Plugin/Basket/Discount` | — |
| Product params | `BasketParams` | `@BasketParams` (`node_type`) | `Plugins\Params\BasketParamsInterface` | `Plugin/Basket/Params` | — |
| Popup system | `BasketPopup` | `@BasketPopupSystem` | `Plugins\Popup\BasketPopupSystemInterface` | `Plugin/Basket/Popup` | — |
| Stock bulk op | `BasketStockBulk` | `@BasketStockBulk` (`weight`, `color`) | `Plugins\Stock\BasketStockBulkInterface` | `Plugin/Basket/Stock` | — |
| Extra settings | `BasketExtraSettings` | `@BasketExtraSettings` | `Plugins\Extra\BasketExtraSettingsInterface` | `Plugin/Basket/Extra` | — |

Bundled example plugins (in core): Discount `DiscountRange`, `DiscountUserPercent`; Delivery
`DeliveryAddressField`, `DeliveryOptionsField` (+ their DeliverySettings); Extra `BasketAdd`; Popup
`BasketPopupBase`. Get one at runtime with `\Drupal::service('<Manager>')->getInstanceById($id)`
(returns `FALSE` if the id/provider is unknown).

## Add a payment gateway

Create `src/Plugin/Basket/Payment/MyGateway.php` in your module:

```php
namespace Drupal\my_pay\Plugin\Basket\Payment;

use Drupal\basket\Plugins\Payment\BasketPaymentInterface;

/**
 * @BasketPayment(
 *   id = "my_gateway",
 *   name = @Translation("My gateway"),
 * )
 */
class MyGateway implements BasketPaymentInterface {
  public function settingsFormAlter(&$form, $form_state) {}     // config fields on the payment type
  public function getSettingsInfoList($tid) { return []; }
  public function createPayment($entity, $order) {             // create a payment; return payID + redirect
    return ['payID' => $id, 'redirectUrl' => $url];
  }
  public function updateOrderBySettings($pid, $order) {}
  public function loadPayment($id) {                            // MUST verify server-side; set isPay only when truly paid
    return ['payment' => $payment, 'isPay' => $paid];
  }
  public function paymentFormAlter(&$form, $form_state, $payment) {}
  public function basketPaymentPages($pageType) {               // $pageType = callback|result|cancel
    return [];
  }
}
```

The framework wires the return/callback/cancel URLs (`Url::fromRoute('basket.pages', ...)` with a
`payInfo` query) into `$payment` before `paymentFormAlter`. On the gateway's return, the storefront
`payment_callback` page calls your `basketPaymentPages('callback')` and only finalises the order
(`Basket::paymentFinish()`) when your `loadPayment()` reports `isPay` **and** the request nid matches
the stored payment nid — so **your `loadPayment()` must confirm the payment server-side** (verify a
signature / query the gateway); never trust inbound request params alone.

## Add a delivery method (shape)

Create `src/Plugin/Basket/Delivery/MyDelivery.php` with `@BasketDelivery`, implementing
`BasketDeliveryInterface` (`basketFormAlter`, `basketSave`, `basketLoad`, `basketGetAddress`,
`deliverySumAlter`, …). Discount plugins implement `discountItem($item)` + `settingsLink()`; params
plugins implement `getParamsForm`/`getDefinitionParams`/`validParams`.
