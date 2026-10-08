<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Price type & VAT category config entities

Two config entity types underpin pricing. Both are `administer prices`-gated and managed under
*Store → Price*.

## `price_type` (`Entity/PriceType`)

A named price list (default, retail, wholesale, …). `@ConfigEntityType` with
`config_prefix: price_type`, `admin_permission: administer prices`.

- **config_export:** `name`, `id`, `description`, `currency`, `base` (`net`|`gross`), `vat_category`,
  `weight`, `locked`.
- **Handlers:** storage `PriceTypeStorage`, list builder `PriceTypeListBuilder`, **access
  `PriceTypeAccessControlHandler`**, forms `PriceTypeForm`/`PriceTypeDeleteForm`, route provider
  `PriceTypeRouteProvider`.
- **Links:** collection `/admin/store/price/type`, add/edit/delete under it.
- **Install default:** `price_type.default` (currency `XXX`, base `net`, vat_category `custom`,
  `locked: true`).

**Access:** `PriceTypeAccessControlHandler` + dynamic per-type permissions from
`Access/PriceTypePermissions::permissions()` (view/create/update/delete per price type). The
negotiation service calls `$priceType->access('view', $account)` so a role that cannot view a price
type never sees or is charged its prices.

## `vat_category` (`Entity/VatCategory`)

A tax rate. `config_prefix: vat_category`, handlers/forms/route-provider mirror price type
(`VatCategoryStorage`, `VatCategoryListBuilder`, `VatCategoryAccessControlHandler`,
`VatCategoryForm`, `VatCategoryDeleteForm`, `VatCategoryRouteProvider`), dynamic permissions from
`Access/VatCategoryPermissions`.

- Key fields: `name`, `id`, `description`, `rate` (float), `weight`, `custom` (bool), `locked`.
- **Install defaults:** `vat_category.default` (`rate: 0.0`, `custom: false`) and
  `vat_category.custom` (`custom: true`, rate entered per price item).

## Managers

`price_type.manager` (`Manager/PriceTypeManager`) and `vat_category.manager`
(`Manager/VatCategoryManager`) are KeyValue+config-factory backed lookup services used across Arch to
resolve types without loading the full entity list repeatedly.
