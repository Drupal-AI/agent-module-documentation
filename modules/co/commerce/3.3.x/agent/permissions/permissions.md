# Permissions

The base module defines a single gate (`commerce.permissions.yml`):

| Permission | Gates |
|---|---|
| `access commerce administration pages` | Reach the Commerce admin area / configuration hub (`/admin/commerce`, `/admin/commerce/config`). |

The bulk of Commerce permissions are provided by the submodules (dynamically, per entity
type/bundle), e.g. `administer commerce_store_type`, `administer commerce_product_type`,
`administer commerce_order`, `manage <type> commerce_product`, checkout/payment/promotion
administration, etc. See each submodule's docs for its permissions.
