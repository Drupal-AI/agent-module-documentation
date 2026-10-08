# Order / pricing integration (the "meat and potatoes")

How selecting a VADO parent variation turns into add-on order items and discounts. Three pieces
cooperate: a **cart event subscriber** (creates the children), an **order processor** (applies the
discount adjustment / calculates the live bundle price), and an **order-item matcher override** (keeps
bundles distinct in the cart).

## Adjustment type

`commerce_vado.commerce_adjustment_types.yml` defines `vado_discount` (`has_ui: true`, `weight: 10`).
Bundle discounts appear as their own `vado_discount` adjustment on order items — separate from Commerce
promotions.

## Cart event subscriber — `commerce_vado.vado_event_subscriber`

Class `EventSubscriber\VadoEventSubscriber`. Subscribes (all at priority -99):

- **`CartEvents::CART_ENTITY_ADD` → `cartEntityAddEvent()`** — the core logic. When a VADO-enabled parent
  order item is added:
  1. Reads parent fields `sync_quantity`, `exclude_parent`, `bundle_discount` (→ multiplier `(100-n)/100`),
     `include_parent`.
  2. Builds an add-on set from `child_variations` (direct) plus any `selected_addon_group_items` (group
     selections stashed on the order item by the Add-to-Cart form). Each add-on price is resolved via
     `commerce_price.chain_price_resolver` with a `Context` carrying `commerce_vado_parent_variation` (and
     `commerce_vado_group_item` for group add-ons), then multiplied by the applicable discount multiplier
     (group / group-item discounts override the parent `bundle_discount` when set).
  3. Creates a child `commerce_order_item` per add-on (title/type from the child variation) and stamps
     `data` keys (see table). Uses the VADO `OrderItemMatcher` to combine identical children *within the
     same bundle*, else adds them to the order.
  4. If `include_parent`, stores `commerce_vado_discount_price` on the parent so the order processor emits
     the parent's discount adjustment.
  5. If `exclude_parent`, deletes the parent order item after adding children (children multiplied by the
     parent quantity).
  6. Unpublished add-on variations are skipped unless `commerce_vado.settings:allow_unpublished_variations`.
- **`OrderEvents::ORDER_PRESAVE` → `orderPreSaveEvent()`** — when `sync_quantity` children exist, resets each
  child's quantity to `parent_qty × commerce_vado_bundle_quantity` and recalculates the order total.
- **`OrderEvents::ORDER_ITEM_DELETE` → `orderItemDeleteEvent()`** — when a synced parent order item is deleted,
  deletes its `commerce_vado_child_order_items`.

> Note: children are added on the **cart add event**, so items added via the admin order UI (which does not
> fire that event) do not receive their add-ons — a maintainer-documented limitation.

## Order processor — `commerce_vado.vado_order_processor`

Class `VadoOrderProcessor` (tag `commerce_order.order_processor`, **priority 600**, `adjustment_type:
vado_discount`). Two modes in `process()`:

- **Normal orders:** for any order item carrying `commerce_vado_discount_price`, sets the discounted unit
  price and adds an included `vado_discount` adjustment for the difference.
- **Live price preview** (`$order->getData('provider') === 'order_price_calculator'`, single item — used by the
  calculated-price formatter on the Add-to-Cart form): `calculateBundlePrice()` sums parent + resolved add-on
  prices (reading current group selections from the POST body `commerce_vado_group`, falling back to widget
  defaults) so the shown price updates in real time. This is display only; the charged price is recomputed on
  cart add from the validated form selection.

## Order-item matcher override — `commerce_vado.order_item_matcher`

Class `OrderItemMatcher extends commerce_cart\OrderItemMatcher`. `CommerceVadoServiceProvider::alter()`
rebinds the core `commerce_cart.order_item_matcher` service to this class. `matchAll()` additionally requires a
matching `commerce_vado_combo_id` (parent id + dash-joined add-on ids) so two carts of the *same* variation but
*different* add-on selections stay separate order items.

## Order-item `data` keys (set on order items at runtime)

| Key | On | Meaning |
|---|---|---|
| `commerce_vado_child_order_items` | parent | IDs of the generated child order items |
| `commerce_vado_synced_child_order_item` | child | whether sync-quantity applied when created |
| `commerce_vado_parent_order_item` | child | back-reference to the parent order item id |
| `commerce_vado_combo_id` | both | unique bundle signature for the matcher |
| `commerce_vado_bundle_quantity` | child | base per-bundle quantity for sync math |
| `commerce_vado_discount_price` | parent/child | pre-computed discounted price for the order processor |
| `commerce_vado_exclude_parent` | parent | flags an excluded ("controller") parent |
| `selected_addon_group_items` | parent | group item IDs chosen on the Add-to-Cart form |

Helper `commerce_vado_order_has_item(OrderInterface $order, OrderItem $orderItem)` (in `.module`) checks by
*purchased entity id* (not order-item id) whether an order already contains an item.
