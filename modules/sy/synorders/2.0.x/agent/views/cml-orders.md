<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cml_orders view — orders listing page

Shipped as default config in `config/install/views.view.cml_orders.yml`. Base table
`commerce_order` (base field `order_id`). Label "Заказы" (Russian: "Orders"). Two displays:

| Display | Plugin | Path |
|---------|--------|------|
| `default` | default | — |
| `page` | page | `/orders` |

The `page` display is the one the module drives (the export controller and the `views_pre_view`
hook both target `cml_orders` / display id `page`). The menu link `synorders.settings` (in
`synorders.links.menu.yml`, menu `editor`) points at `internal:/orders`.

## Access

```yaml
access:
  type: perm
  options:
    perm: 'administer commerce_order'
```

Viewing `/orders` requires the core-Commerce `administer commerce_order` permission. `synorders.install`
grants that permission to the `editor` role on install (revokes on uninstall), so any user with the
`editor` role can reach this page and its export.

## Relationship

- `uid` — a `standard` relationship on `commerce_order.uid` to the **User** entity (`required: false`).
  All customer fields below are pulled through it.

## Fields (columns)

| Field | Source | Label |
|-------|--------|-------|
| `order_number` | `commerce_order.order_number` | Номер заказа (Order number), links to the order entity |
| `field_user_name` | `user__field_user_name` (via `uid`) | Имя (Name) |
| `field_user_surname` | `user__field_user_surname` (via `uid`) | Фамилия (Surname) |
| `field_user_phone` | `user__field_user_phone` (via `uid`) | Телефон (Phone) |
| `mail` | `users_field_data.mail` (via `uid`) | Email |
| `created` | `commerce_order.created` | Создано (Created) — short date |
| `total_price__number` | `commerce_order.total_price` | Общая стоимость (Total) — `commerce_price_default`, symbol |

The custom user fields (`field_user_name`, `field_user_surname`, `field_user_phone`) are **site-provided**,
not shipped by this module — the view config `dependencies.config` lists `field.storage.user.field_user_*`,
so they must already exist on the User entity.

## Exposed filters

All in filter group 1 (AND), exposed form type `basic` (submit "Применить"):

- `order_number` (string `=`)
- `field_user_name_value` / `field_user_surname_value` / `field_user_phone_value` (string `=`, via `uid`)
- `mail` (string `=`)
- `state` (`state_machine_state`, operator `in`, **default value `completed`**)

A non-exposed `type` filter pins the order bundle to `default` (`commerce_entity_bundle`). Sorts:
`completed` and `created`, both DESC (not exposed). Pager: full, 25/page.

## Config dependencies

```yaml
dependencies:
  config:
    - commerce_order.commerce_order_type.default
    - field.storage.user.field_user_name
    - field.storage.user.field_user_phone
    - field.storage.user.field_user_surname
  module: [commerce, commerce_order, commerce_price, state_machine, user]
```

These are **not** mirrored in `synorders.info.yml` `dependencies` (which is empty), so Composer/info
resolution will not pull them — the site must supply the Commerce order type and the three user fields
before installing, or config import of this view fails.

The `views_pre_view` header link that turns this page into an Excel export is documented in
[`../routes/export.md`](../routes/export.md).
