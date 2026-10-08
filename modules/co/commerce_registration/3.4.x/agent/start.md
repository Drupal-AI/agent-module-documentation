<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Registration (commerce_registration) — agent index

Sells [Registration](https://www.drupal.org/project/registration) sign-ups through Drupal Commerce.
A Commerce **product variation** becomes a registration host; adding it to the cart creates a
registration, and the order's payment state drives the registration state. No purchasable
"registration" entity is defined — the existing product variation is the purchasable entity and the
registration is attached to the order item.

- Core: `^10.3 || ^11`. Composer: `drupal/commerce ^3.0`, `drupal/registration ^3.4.2`.
- Dependencies: `commerce`, `commerce_cart`, `commerce_checkout`, `commerce_order`, `commerce_price`,
  `commerce_product`, `registration`.
- **No module settings page** (`configure` route is null). Configuration is per product variation via
  the product's **Registration Settings** local task, plus checkout-flow pane placement.
- Defines **no permissions** and **no drush commands**. Route access uses a custom access check that
  delegates to the Registration module. Defines **no new plugin types** (ships plugin instances only).
- Ships two submodules (separate enable, own dependencies): `commerce_registration_waitlist`
  (integrates `registration_waitlist`: waitlisted items priced 0 until a space frees) and
  `commerce_registration_change_host` (integrates `registration_change_host`: move a registration to
  another variation/session).

What you'd do → where:
- **Enable registration on a product / place checkout panes / set holds** → [configure/setup.md](configure/setup.md)
- **Understand the cart→checkout→paid→canceled registration lifecycle, services, base fields** → [api/lifecycle.md](api/lifecycle.md)
- **Use the checkout panes, inline form, add-to-cart widgets, availability checker** → [plugins/checkout.md](plugins/checkout.md)
- **Hook into order/registration processing (access, deletion, base fields, alters)** → [hooks/hooks.md](hooks/hooks.md)
- **The Manage Registrations listings and Views plugins** → [views/views.md](views/views.md)

Key facts (real machine names):
- Routes (all `_admin_route`, gated by `_manage_commerce_registrations_access_check`):
  `entity.commerce_product.commerce_registration.manage_registrations`
  (`/product/{commerce_product}/registrations`), `...registration_settings`
  (`/registrations/settings`), `...broadcast` (`/registrations/broadcast`).
- Services: `commerce_registration.availability_checker` (tag `commerce_order.availability_checker`),
  `commerce_registration.registration_order_processor` (tag `commerce_order.order_processor`, priority
  100), `commerce_registration.manager`, and event subscribers `cart_subscriber`,
  `order_subscriber`, `product_subscriber`, `registration_subscriber`, plus access checker service
  `commerce_registration.manage_commerce_registrations_access_checker`.
- Checkout panes: `registration_process` (default step `payment`), `registration_information`.
  Inline form: `registration`. Add-to-cart widgets: `commerce_registration_variation_title`,
  `commerce_registration_variation_details`.
- Base fields added: `commerce_order_item.registration` (ref → `registration`, read-only, unlimited),
  `registration.order_id` (ref → `commerce_order`, read-only).
- Config schema: `field.widget.settings.commerce_registration_variation_title`. Log category:
  `commerce_registration` (entity_type `commerce_order`).
