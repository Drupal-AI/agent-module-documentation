<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Variation Add On (commerce_vado) — agent index

VADO = **Variation Add-On**. Lets a Drupal Commerce product **variation** reference *other*
variations (directly, or via reusable "groups"), and auto-adds those add-ons to the cart as their
own order items when the parent is added. Supports bundle quantity-sync, an optional bundle percentage
discount (its own `vado_discount` adjustment type), a "controller" parent (zero-priced / excluded), and
5 pluggable widgets for choosing group add-ons on the Add to Cart form.

Dependencies: `commerce:commerce_cart`, `commerce:commerce_product`, `commerce_price` (composer:
`drupal/commerce ~2.8 || ^3.0`). Configure route: **`commerce_vado.manage`** → `/admin/commerce/config/vado`.
Ships permissions, config schema, a plugin type, 2 content entities, a Views view, and an order processor.
No Drush.

- **Enable the add-on fields on a variation type + toggle the two settings** → [configure/manage.md](configure/manage.md)
- **Who may administer add-ons and groups** → [permissions/permissions.md](permissions/permissions.md)
- **How add-ons and discounts actually reach the order (adjustment, order processor, cart events)** → [api/order-integration.md](api/order-integration.md)
- **The `commerce_vado_group` / `commerce_vado_group_item` entities + helper services** → [api/entities.md](api/entities.md)
- **Add-on group widgets (5 built-in) and how to add one** → [plugins/vado-group-widget.md](plugins/vado-group-widget.md)
- **The `order_item_vado` promotion condition** → [plugins/order-item-condition.md](plugins/order-item-condition.md)
- **The group Add-to-cart field formatter + `vado_group_add_to_cart` order-item form mode** → [fields/group-add-to-cart-formatter.md](fields/group-add-to-cart-formatter.md)
- **The groups admin view + custom Views plugins for rendering group items** → [views/views.md](views/views.md)

Key facts:
- Config object **`commerce_vado.settings`** keys: `hide_parent_zero_price`, `allow_unpublished_variations` (both stored as string/bool checkboxes).
- Adjustment type **`vado_discount`** (`commerce_vado.commerce_adjustment_types.yml`, `has_ui: true`, `weight: 10`).
- Six variation fields (added by the config form, not on install): `child_variations`, `variation_groups`, `sync_quantity`, `bundle_discount`, `include_parent`, `exclude_parent` (see configure/manage.md).
- Plugin type **`commerce_vado.vado_group_widget`**, manager `plugin.manager.commerce_vado_group_widget`, annotation `@CommerceVadoGroupWidget`, base `VadoGroupWidgetBase`.
- Content entities: `commerce_vado_group` (base_table `commerce_vado_group`, admin perm `administer commerce_vado_group`), `commerce_vado_group_item`.
- Services: `commerce_vado.field_manager`, `commerce_vado.vado_order_processor` (order processor, priority 600), `commerce_vado.vado_event_subscriber`, `commerce_vado.order_item_matcher` (also decorates `commerce_cart.order_item_matcher` via `CommerceVadoServiceProvider`), `commerce_vado.lazy_builders`.
- Permissions: `access vado administration pages`, `administer commerce_vado_group` (restricted).
- Order-item `data` keys used at runtime: `commerce_vado_child_order_items`, `commerce_vado_synced_child_order_item`, `commerce_vado_parent_order_item`, `commerce_vado_combo_id`, `commerce_vado_bundle_quantity`, `commerce_vado_discount_price`, `commerce_vado_exclude_parent`, `selected_addon_group_items`.
- `commerce_vado.post_update.php` is empty in 3.0.x; upgrade steps are `commerce_vado_update_8201`..`_8204` in `.install` — run `drush updatedb` after upgrading from 2.x.
