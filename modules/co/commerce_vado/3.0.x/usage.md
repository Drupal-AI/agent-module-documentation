<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Variation Add On (VADO) lets one Drupal Commerce product variation reference other variations — directly, or through reusable "groups" — and automatically adds those add-ons to the cart as their own order items when the parent variation is added. It supports quantity-synced bundles, an optional percentage bundle discount with its own adjustment type, a zero-priced/excluded "controller" parent, and five pluggable widgets for choosing group add-ons on the Add to Cart form.

---

Configure it at `/admin/commerce/config/vado` (route `commerce_vado.manage`), where you enable per variation-type fields: `child_variations` and `variation_groups` (the two primary reference fields), plus `sync_quantity`, `bundle_discount`, `include_parent`, and `exclude_parent`. Add-ons are attached at cart-add time by `VadoEventSubscriber` (on `CartEvents::CART_ENTITY_ADD`), which resolves each add-on's price through the chain price resolver, applies the effective discount (group-item → group → parent `bundle_discount`), and creates child order items; `VadoOrderProcessor` (order processor, priority 600) records the discount as a `vado_discount` adjustment and also computes the live bundle price for the calculated-price formatter. Reusable add-on sets are modelled by the `commerce_vado_group` / `commerce_vado_group_item` content entities managed at `/admin/commerce/vado-groups` (permission `administer commerce_vado_group`), each group carrying a widget plugin (checkboxes, radios, select, multi-select, or static list) from the `commerce_vado.vado_group_widget` plugin type. A dedicated field formatter (`commerce_vado_group_add_to_cart`) and order-item form mode render the group widgets on the product page, an `order_item_vado` promotion condition lets offers skip bundle items, and custom Views plugins render group-item option labels and expose discounted-price fields. Two module settings — `hide_parent_zero_price` and `allow_unpublished_variations` — round out the behavior.

---

- Auto-add a set of accessory variations whenever a specific parent variation is added to the cart.
- Offer add-ons that depend on the exact variation (size/colour) the customer chose.
- Build a configurator-style Add-to-Cart form with several add-on groups on one product.
- Let shoppers pick optional add-ons via checkboxes, radios, a select list, or a multi-select.
- Present a fixed, non-editable bundle using the static-list widget.
- Lock each child variation's cart quantity to the parent quantity (true bundle).
- Apply a flat percentage discount to all of a parent's child variations.
- Give individual groups or group items their own discount that overrides the parent's.
- Exclude a specific group or item from the bundle discount by setting its discount to 0.
- Include the parent variation itself in the bundle discount.
- Make the parent a zero-priced "cart controller" and hide its price in cart/order views.
- Exclude the parent from the order entirely, adding only its children to the cart.
- Report bundle discounts separately from promotions via the `vado_discount` adjustment type.
- Show real-time bundle price updates as add-ons are selected on the product page.
- Reuse a curated add-on group across many parent variations.
- Duplicate an existing add-on group (with its items) as a starting point for a new one.
- Set default add-on selections that are pre-checked on the Add-to-Cart form.
- Require a group so the customer must choose at least one add-on.
- Render group-item option labels through a Views display for custom markup and pricing.
- Keep separate cart lines for the same variation bought with different add-on selections.
- Delete a bundle's child items automatically when the synced parent is removed.
- Allow (or block) unpublished child variations from being added to orders via a setting.
- Exclude VADO bundle items from a store-wide promotion using the `order_item_vado` condition.
- Bundle a subscription or warranty variation with a specific hardware variation.
- Add a custom group widget by implementing a `@CommerceVadoGroupWidget` plugin.
- Enable VADO fields on a variation type programmatically via the `commerce_vado.field_manager` service.
- Expose group-item discounted price and discount amount as Views fields.
