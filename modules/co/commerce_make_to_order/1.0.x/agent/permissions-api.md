<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_make_to_order — permissions, routes & API

## Permissions (`commerce_make_to_order.permissions.yml`)
| Permission | Notes |
|---|---|
| `administer mto orders` | Full control; bypasses the access handler. `restrict access: true`. |
| `administer mto order types` | Manage config bundles. `restrict access: true`. |
| `view any mto order` | View all; also gates the MTO orders menu/collection route. |
| `view own mto orders` | View orders you own or are assigned to. |
| `create mto orders` | Manual creation. |
| `update any mto order` | Edit all. |
| `update own mto orders` | Edit orders you own or are assigned to. |
| `delete any mto order` | `restrict access: true`. |
| `transition mto orders` | Change order states. |
| `cancel mto orders` | Enforced by `MtoOrderCancelGuard`. `restrict access: true`. |
| `view mto analytics` | Analytics report page. |
| `add mto notes` | Add MTO notes without edit access. |

All permissions are staff-oriented; grant `any`/`administer`/`transition` only to production staff. Assign the `administer`/`restrict access` permissions to trusted roles only.

## Access control (`src/Access/MtoOrderAccessControlHandler.php`)
`administer mto orders` allows everything. `view`/`update` honour "any" vs "own" (owner OR assigned user). Create gated by `create mto orders`. Cacheability set per-permissions (+ per-user/entity for "own"). Update access is also granted to holders of `transition mto orders` so the state-transition flow works; keep that permission scoped to production staff.

## Routes (`*.routing.yml` + entity route provider)
- `commerce_make_to_order.mto_orders` — `/admin/commerce/mto-orders` menu block, `_permission: view any mto order`.
- `entity.mto_order.state_transition_form` — `/admin/commerce/mto-orders/{mto_order}/state/{field_name}/{transition_id}`, `_entity_access: mto_order.update`; overridden by `MtoOrderRouteSubscriber` to `MtoOrderStateTransitionForm` (adds optional transition-note textarea when the type enables it).
- `commerce_make_to_order.analytics` — `/admin/commerce/mto-orders/analytics`, `_permission: view mto analytics`.
- Entity CRUD (add/canonical/edit/delete/collection) via `AdminHtmlRouteProvider` under `/admin/commerce/mto-orders/…`; MTO order types under `/admin/commerce/config/mto-order-types/…` (`admin_permission = administer mto order types`).

## Forms
- `MtoOrderForm` (add/edit): AJAX-filters the `order_item` select to the chosen Commerce order's items; auto-syncs `product_variation` from the item in `preSave`.
- `MtoOrderStateTransitionForm`: extends State Machine's confirm form; logs an optional `mto_order_transition_note` when notes are enabled.
- `MtoProductionNoteForm` (rendered on the order view when the user has `add mto notes`): logs `mto_order_note`; if a notification email is configured on the type and "Notify e-commerce team" is checked, also logs `commerce_order_mto_note` on the Commerce order and emails the fixed configured address via `hook_mail` key `mto_note`.

## Entity-reference selection
`mto_user_selection` (`MtoUserSelection`, extends core `UserSelection`) restricts the `assigned` field to users holding `administer mto orders`, `update any mto order`, or `update own mto orders`.

## Drush (`src/Drush/Commands/MtoCommands.php`)
`commerce_make_to_order:create <order_id>` (aliases `mto:create`, `mto-create`) — create MTO orders for every item of a Commerce order. Options: `--type` (default `default`), `--force` (create even if MTO orders already exist).

## Events & extension
- `MtoOrderEvents::MTO_ORDER_CREATE` (`commerce_make_to_order.mto_order.create`) — dispatched with `MtoOrderEvent($mto_order, $order, $order_item)` before save (auto-create and Drush paths). Subscribe to set fields/defaults.
- Standard `commerce_make_to_order.<transition>.(pre|post)_transition` State Machine events.
- Custom workflows: `*.workflows.yml` with `group: commerce_make_to_order`, then pick it on the MTO order type.
- Custom number patterns: create a `commerce_number_pattern` with `targetEntityType: mto_order` and assign it to the type; else `MtoOrder` falls back to `MTO-YYYY-NNNNN`.

## API sketch
```php
// Load by Commerce order.
$mto = \Drupal::entityTypeManager()->getStorage('mto_order')
  ->loadByProperties(['commerce_order' => $order_id]);

// Create + transition.
$m = \Drupal::entityTypeManager()->getStorage('mto_order')->create([
  'type' => 'default', 'commerce_order' => $order->id(),
  'order_item' => $item->id(), 'quantity' => (int) $item->getQuantity(),
  'priority' => 'normal',
]);
$m->save();
$m->getState()->applyTransitionById('start');
$m->save();
```
