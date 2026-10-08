<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_make_to_order — agent start

**Make-to-order (build-on-demand) production workflow for Drupal Commerce.** Version **1.0.1**, core `^10 || ^11`, PHP `>=8.1`. Package `Commerce`. Not security-advisory covered.

Turns each **order item** of a Commerce order into a **production order** (`mto_order` content entity) that staff drive through a State-Machine workflow (Draft → Queued → In Production → Quality Check → Completed, plus Waiting-for-Materials, Rework, Canceled). The parent Commerce order can follow along automatically. Everything is admin-facing under `/admin/commerce/…`; **no customer-facing routes**, and the `mto_order` entity carries no price (quantity is copied server-side from the order item).

Depends on: core `user`, `commerce`, `commerce_order`, `commerce_number_pattern`, `commerce_log`, `state_machine`. Optional `commerce_shipping` (shipment-integration mode) and `commerce_order_amend` (item-swap sync).

Config UI: **Commerce → Configuration → MTO order types** (`/admin/commerce/config/mto-order-types`). Working list: **Commerce → MTO orders** (`/admin/commerce/mto-orders`). Analytics: `/admin/commerce/mto-orders/analytics`.

## Entities
- **`mto_order`** (content, bundle = `mto_order_type`): base table `mto_order`; label = `mto_order_number` (auto-generated via Commerce Number Pattern, fallback `MTO-YYYY-NNNNN`). Fields: `commerce_order`, `order_item`, `product_variation` (auto-synced from order item in `preSave`), `quantity` (min 1), `state` (State Machine), `priority` (low/normal/high/urgent), `due_date`, `estimated_completion_date`, `assigned` (required, `mto_user_selection` handler), `notes` (text_long), `started_at`/`completed_at`/`shipped_at`, `uid` (owner), and `shipment` (only when `commerce_shipping` is installed — added via `hook_entity_base_field_info`). `src/Entity/MtoOrder.php`.
- **`mto_order_type`** (config bundle): all behaviour toggles — workflow, number pattern, auto-create + trigger state (`paid`), default assignee, checkout-field display, transition notes, state-sync vs shipment-integration, hold states, production-note email, estimated-completion days. `src/Entity/MtoOrderType.php`.
- Extra DB table **`mto_order_state_history`** (`.install` `hook_schema`): per-transition rows with duration for analytics.

## Topics
- Data model, workflow, auto-creation, Commerce-order integration modes (state-sync / shipment), subscribers, services, analytics, templates → [architecture.md](architecture.md)
- Permissions, entity access control, routes, Drush, events/hooks, extension points → [permissions-api.md](permissions-api.md)

## Quick facts
- Default workflow `mto_order_default` (group `commerce_make_to_order`), 8 states / 9 transitions — see `commerce_make_to_order.workflows.yml`.
- Auto-create: `OrderCompleteSubscriber` on `commerce_order.post_transition` creates one `mto_order` per order item when the order reaches the type's `autoCreateOnState` (default `paid`); dedupes by order item; idempotent.
- Completion sync: when **all** MTO orders of a Commerce order reach the trigger state, the module transitions the parent order (state-sync → e.g. `shipped`; shipment-integration → `ready_to_ship`). Configurable **hold states** block auto-promotion and log a note instead.
- Drush: `drush commerce_make_to_order:create <order_id>` (aliases `mto:create`, `mto-create`), options `--type`, `--force`.
- Programmatic: create an `mto_order` via storage, `->save()`; transition with `$mto_order->getState()->applyTransitionById('start'); $mto_order->save();`.

## Security posture (public)
Price/fulfillment integrity: no price on the entity, quantity copied from the order item server-side, all routes admin-permission or entity-access gated, no customer endpoints. Activity-log note params render through Twig autoescaping (`nl2br`); no `|raw` on order/product data. State-changing forms are standard Drupal forms (CSRF-tokened); the analytics filter is a read-only GET. DB access uses parameterized queries throughout.
