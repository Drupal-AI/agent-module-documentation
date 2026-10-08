<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Product Alternative lets shoppers swap a variation already in their cart for an admin-designated alternative, in place, via an AJAX modal.

---

Commerce Product Alternative adds a Commerce entity trait and an AJAX switch flow so a shopper can replace a cart line item with an alternative product variation (e.g. a different size, format, or configuration) without removing and re-adding it. Store managers assign the valid alternatives on each variation; swap links appear in the cart (via a dedicated Views field) and clicking one opens a confirmation modal that shows the current and target price, then replaces the underlying order item — preserving quantity and custom fields and resolving the new price.

It is a Commerce storefront-UX feature. Access is validated per switch (the cart must be the shopper's own draft cart and the target must be a published, available, listed alternative); there is no role permission or settings form. Depends on Commerce `commerce`, `commerce_product`, `commerce_order`, `commerce_cart`, and `commerce_log`; requires Drupal 11.

---

- Offer admin-designated alternative variations per variation.
- Swap a cart line item to an alternative via AJAX.
- Replace the order item in place, no manual remove/re-add.
- Preserve quantity and copy shared custom fields.
- Resolve the alternative's price on switch.
- Show a confirmation modal with current vs. target price.
- Avoid full page reloads.
- Provide a Commerce entity trait for variation types.
- Expose swap links through a Views field on order items.
- Log each switch to the order via commerce_log.
- Restrict switches to published, available alternatives.
- Validate cart ownership before switching.
- Prevent a variation referencing itself as an alternative.
- Support an optional per-item CTA link label.
- Depend on Commerce product/order/cart/log.
- Require Drupal 11.
- Improve storefront cart UX.
