<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Order Item UI — agent index

Adds a standalone admin UI for Drupal Commerce **order items** (`commerce_order_item`), all
nested under an order at `/admin/commerce/orders/{commerce_order}/order-items/...`. No config
UI (`configure: null`), no entities, no permissions, no Drush of its own — it only alters the
existing `commerce_order_item` entity type.

- **Routes / link templates / list + tab, and how to reach the UI** →
  [api/order-item-ui.md](api/order-item-ui.md)
- **Who can access it (the Commerce permissions the access checkers use)** →
  [permissions/access.md](permissions/access.md)

Key facts: registered in `hook_entity_type_alter()` — a custom `OrderItemRouteProvider`,
`OrderItemListBuilder`, add/edit/duplicate/delete forms, and link templates `collection`,
`add-page`, `add-form`, `edit-form`, `duplicate-form`, `delete-form`. Access is gated by the
Commerce permissions `administer commerce_order`, `access commerce_order overview`, and
`manage <order_item_type> commerce_order_item`. The add form's `purchased_entity` is limited to
the variation types mapped to each order-item type via `hook_entity_bundle_field_info_alter()`.
