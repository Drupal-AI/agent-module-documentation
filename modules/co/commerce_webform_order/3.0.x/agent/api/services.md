# Services, tokens, hooks & base field

## Services (`commerce_webform_order.services.yml`)
| Service id | Class / interface | Purpose |
|---|---|---|
| `commerce_webform_order.access_checker` | `AccessChecker` (`AccessCheckerInterface`) | `updateAccess($webform_submission, $account)` → `forbidden` when the linked order item has `prevent_update` and its order is not `draft`; else `neutral`. Never grants access. |
| `commerce_webform_order.order_item_repository` | `OrderItemRepository` (`OrderItemRepositoryInterface`) | `getLastByWebformSubmission($submission, $handler_id = NULL)` — finds the most recent order item created from a submission (via the base field). |
| `commerce_webform_order.options_builder` | `PaymentOptionsBuilder` (`PaymentOptionsBuilderInterface`) | Builds `PaymentOption[]` (new + stored payment methods) for the Payment Method element. |
| `commerce_webform_order.order_transition_subscriber` | `EventSubscriber\OrderTransitionSubscriber` | On order state transition, pushes the order state onto linked submissions. |
| `commerce_webform_order.order_paid_subscriber` | `EventSubscriber\OrderPaidSubscriber` | On order paid, pushes payment status onto linked submissions. |

Both subscribers use `WebformSubmissionUpdaterTrait` (methods
`updateWebformSubmissionsOrderStateFromOrder`, `updateWebformSubmissionsPaymentStatusFromOrder`,
`collectAllWebformSubmissionsFromOrder`, …) to find every submission attached to an order and
write the Order State / Payment Status element values back.

## Base field
`commerce_webform_order_entity_base_field_info` adds `commerce_webform_order_submission` (an
`entity_reference` to `webform_submission`, cardinality 1) to `commerce_order_item`, linking each
generated order item to the submission that created it. Hidden on form/view by default.

## Tokens (`commerce_webform_order.tokens.inc`)
Adds tokens on the `webform_submission` token type:
- `[webform_submission:commerce_order]` → the `commerce_order` associated with the submission.
- `[webform_submission:commerce_order_item]` → the associated `commerce_order_item`.
Chained token types resolve through the standard token service; the order/order item are found
via `commerce_webform_order.order_item_repository`. Install `token`/`token_or` (suggested) for
the UI and or-able tokens.

## Hook you can implement (`commerce_webform_order.api.php`)
```php
/**
 * Alter the order, order item and submission just before they are saved.
 */
function hook_commerce_webform_order_handler_postsave_alter(
  \Drupal\commerce_order\Entity\OrderInterface $order,
  \Drupal\commerce_order\Entity\OrderItemInterface $order_item,
  \Drupal\webform\WebformSubmissionInterface $webform_submission
) {
  $order->setData('sashay', 'away');
}
```
Invoked from `CommerceWebformOrderHandler::postSave()` before save — use it to add order data,
adjust adjustments, tweak the order item, etc.

## Other hook implementations (module-internal, for reference)
- `hook_ENTITY_TYPE_access` for `webform` + `webform_submission` — token/owner-scoped update
  access via the access checker (see configure/handler.md `prevent_update`).
- `hook_ENTITY_TYPE_delete` for `commerce_order_item` — deletes the linked submission when
  `sync` is set.
- `hook_commerce_checkout_pane_info_alter` — registers the Payment process pane.
- `hook_form_FORM_ID_alter` for `webform_settings_confirmation_form` — warns that the
  confirmation is overridden when the handler's `redirect` is on.

No permissions, no Drush commands, no plugin managers are provided by this module.
