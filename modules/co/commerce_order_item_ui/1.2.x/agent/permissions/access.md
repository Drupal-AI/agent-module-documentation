<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access to the order-item UI

This module defines **no permissions of its own** (no `*.permissions.yml`). Access to its routes
is decided by two custom access checkers that reuse **Commerce** permissions.

## Collection / listing — `_order_item_collection_access`

`OrderItemCollectionAccessCheck` (service `access_check.order_item_collection`) grants access to
the per-order order-items listing if the account holds **any** of:

- `administer commerce_order`
- `access commerce_order overview`
- `manage <order_item_type> commerce_order_item` — for any order-item type on the site
  (e.g. `manage default commerce_order_item`).

It loads the order from the route, resolves its order type, and builds that permission list
(`allowedIfHasPermissions(..., 'OR')`). No order in the route → forbidden.

## Add / create — `_order_item_create_access`

`OrderItemCreateAccessCheck` (service `access_check.order_item_create`) defers to the
`commerce_order_item` entity **access control handler's** `createAccess()` for the specific
order-item type in the route. If the route has a bundle it checks create access for that bundle;
otherwise returns neutral. An unknown/invalid bundle → forbidden.

## Practical grants

- Full management (add/edit/delete all order items): `administer commerce_order`.
- View the listing only: `access commerce_order overview`.
- Limit a role to specific line-item types: give `manage <type> commerce_order_item` for just
  those types.

These permissions are provided by the `commerce_order` module; assign them at
`/admin/people/permissions` under the Commerce Order section.
