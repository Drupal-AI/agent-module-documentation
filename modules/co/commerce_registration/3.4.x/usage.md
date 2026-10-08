<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Registration lets a Drupal Commerce store sell event sign-ups: a product variation becomes a Registration host, adding it to the cart creates a registration, and the order's payment state drives the registration from held/pending to complete. Capacity is checked server-side and abandoned carts release their held spaces.

---

The module joins two subsystems: Registration models capacity and sign-ups against a host entity, while Commerce models products, carts, orders and payment. Here the purchasable entity is the existing Commerce **product variation** — you add a `registration` field to the variation type (never the product type; an install requirement and a field-storage constraint enforce this), pick a registration type per variation, and the product gains a Manage Registrations local task. During checkout one of two panes creates the registrations: `registration_process` (silent, buyer-only, placed before Payment Process) or `registration_information` (an inline form per space for entering field data or registering others). A tagged availability checker validates the requested quantity against the host's remaining room on every cart/checkout refresh, and a product-variation filter hides full or closed variations from add-to-cart forms; an order processor prunes items whose registrations were canceled or expired. The order subscriber moves held registrations to pending on order placement, to complete when the order is fully paid, and to canceled when a cart order is canceled; cart edits and deletions clean up the corresponding registrations. Order-item unit prices come from Commerce's own price resolution — the module never trusts a client-supplied price, and the registration count mirrors the server-side order-item quantity. Access to the manage/settings/broadcast routes is delegated per variation to the Registration module's own manage-registrations access check rather than any permission defined here. Two optional submodules extend the flow: `commerce_registration_waitlist` (waitlisted items priced free until a space opens) and `commerce_registration_change_host` (move a registration to another variation/session). Requires Commerce `^3.0`, Registration `^3.4.2`, core `^10.3 || ^11`.

---

- Sell tickets to an event as a Commerce product.
- Create an event registration automatically when a product is purchased.
- Enforce event capacity through Commerce checkout and add-to-cart forms.
- Show remaining spaces on the add-to-cart form (spaces-available widget).
- Collect extra registration field data during checkout.
- Let a buyer register other people, not just themselves.
- Put a hold on limited spaces while the buyer completes checkout.
- Release held spaces automatically from abandoned carts.
- Confirm a registration only after full payment is received.
- Sell multiple ticket types per event via product variations.
- Combine event tickets with other products in one cart.
- Manage all registrations for a product from its Manage Registrations tab.
- Edit per-variation registration settings from the product Settings tab.
- Email all registrants of a product or a single variation.
- Report on registrations alongside orders in Views.
- Charge different prices per attendee type using variations.
- Prevent deleting a registration that is in use by an order.
- Migrate Drupal 7 registrations with their order association.
- Hide the email filter on large registration lists automatically.
- Put attendees on a waitlist when an event fills (waitlist submodule).
- Move a registration to a different session (change-host submodule).
