# Services, base fields & the registration lifecycle

## Base fields (added via `hook_entity_base_field_info`)

| Entity type | Field | Type | Notes |
|---|---|---|---|
| `commerce_order_item` | `registration` | entity_reference → `registration` | **read-only**, cardinality unlimited. Links an order item to the registration(s) it created. |
| `registration` | `order_id` | entity_reference → `commerce_order` | **read-only**. Links a registration back to its order. |

Both are `setReadOnly(TRUE)`, so a client cannot post arbitrary references into them; the module sets
them server-side (`order_id` from `$this->order->id()` / the inline-form config, the `registration`
reference by appending the saved registration id).

## Services

| Service id | Class | Role |
|---|---|---|
| `commerce_registration.availability_checker` | `CommerceRegistrationAvailabilityChecker` | Tagged `commerce_order.availability_checker`. Commerce calls it to keep cart items available. |
| `commerce_registration.registration_order_processor` | `OrderProcessor\RegistrationOrderProcessor` | Tagged `commerce_order.order_processor` (priority 100). Prunes items whose registrations became invalid. |
| `commerce_registration.manager` | `CommerceRegistrationManager` | Helper: `getProductIdFromArgument(string): ?int` — resolves a product id from a `1+2+3` variation-id views argument (loads the first variation, returns its product id). |
| `commerce_registration.manage_commerce_registrations_access_checker` | `Access\ManageCommerceRegistrationsAccessCheck` | Route access for the manage/settings/broadcast routes (see configure/setup.md). |
| `commerce_registration.cart_subscriber` / `.order_subscriber` / `.product_subscriber` / `.registration_subscriber` | `EventSubscriber\*` | Lifecycle glue below. |

### Availability checker (`CommerceRegistrationAvailabilityChecker`)

- `applies()`: true only when the purchased entity is a `ProductVariationInterface`, its host entity
  `isConfiguredForRegistration()`, **and** the order item has **no** registration attached yet (items
  that already hold registrations are handled by the order processor instead).
- `check()`: calls the Registration module's `HostEntity::hasRoomForRegistration((int) $order_item->getQuantity(), TRUE)`.
  If invalid it returns `AvailabilityResult::unavailable()` and surfaces each violation via the
  messenger; otherwise `AvailabilityResult::neutral()`. **Capacity is validated server-side against the
  live host entity**, using the requested quantity — the client cannot request more spaces than remain.

### Order processor (`RegistrationOrderProcessor::process`)

Runs on every order refresh. For each item with attached registration(s): removes the item (and deletes
its registrations) if the host is no longer configured for registration, or if any attached registration
`isCanceled()` (e.g. a held registration expired before checkout completed). Items whose purchased entity
vanished are also removed. Removal failures are swallowed (item is already out of the cart).

## Add-to-cart availability filtering

`ProductEventSubscriber::onFilterVariations` (subscribes to `ProductEvents::FILTER_VARIATIONS`) removes
registration-configured variations that are **not** `isAvailableForRegistration()` from add-to-cart
variation lists, so a full/closed variation cannot be selected.

## Registration creation

Registrations are created during checkout by whichever pane is enabled (see
[plugins/checkout.md](../plugins/checkout.md)):

- `registration_process` pane (`buildPaneForm`): for each item configured for registration with an empty
  `registration` field, creates a registration via `HostEntity::createRegistration()`, sets
  `order_id` = order id, `author_uid` = current user, `count` = `(int) $item->getQuantity()`,
  `langcode` = current language, and either `user_uid` = order customer (authenticated) or
  `anon_mail` = order email (anonymous). Saves it and appends the id to the order item's `registration`.
- `registration_information` pane: builds an inline `registration` form per space; the inline form's
  `submitInlineForm` sets `order_id` and saves each registration, then the pane attaches them to the item.
  The inline form forces `count` hidden (one space per registration) so aggregate spaces cannot exceed the
  item quantity.

**Ownership:** a registration created at checkout is keyed to the order's customer (`user_uid` /
`anon_mail`), and `author_uid` records who performed it. Registering *another* user is only possible when
the registration type allows it (the "who is registering" options come from the Registration module's
`getRegistrantOptions()`), and is validated by the Registration module's own registration constraint.

## State transitions (`OrderSubscriber`)

| Event | Method | Effect on registrations for that order |
|---|---|---|
| `commerce_order.place.post_transition` (prio 100) | `onOrderPlace` | Held registrations → `pending` (if the workflow has that state). |
| `OrderEvents::ORDER_PAID` (prio 100) | `onOrderPaid` | Active or held registrations → `complete` (if the workflow has that state). |
| `OrderEvents::ORDER_UPDATE` (prio 100) | `onOrderUpdate` | For orders still flagged as a **cart** that moved to `canceled`: active/held, not-complete registrations → `canceled`. |

Registrations are loaded by `order_id` (`registration` storage `loadByProperties`).

## Cart edits & deletions (`CartEventSubscriber`, `hook_entity_delete`)

- `onCartItemRemove` (`CART_ORDER_ITEM_REMOVE`): deletes the registrations referenced by a removed item.
- `onCartItemUpdate` (`CART_ORDER_ITEM_UPDATE`): when quantity is reduced, deletes the surplus
  registrations from the end of the reference list and saves the item.
- `commerce_registration_entity_delete()` also cleans up when items/orders are deleted programmatically:
  deleting an **order** nulls the `order_id` on its registrations; deleting an **order item** (e.g.
  abandoned-cart deletion) deletes its non-complete registrations. See [hooks/hooks.md](../hooks/hooks.md).

Net effect: an in-cart (not yet paid) registration is created immediately and holds capacity until the
cart item is removed/reduced or the cart is canceled/abandoned. Use the "Held" default state plus a hold
length or abandoned-cart deletion (configure/setup.md) to release capacity from stalled checkouts.
