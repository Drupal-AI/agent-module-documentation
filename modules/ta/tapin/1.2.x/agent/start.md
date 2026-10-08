<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tapin (tapin) — agent index

**Commerce order integration: REST endpoints to list pending fulfilment orders and write back a tapin barcode/check, plus a React admin order screen.**

- **Version:** 1.2.x
- **Core:** ^8 || ^9 || ^10
- **Depends on:** commerce, commerce_order, rest.
- **Configure:** `tapin.settings_form` → `/admin/config/system/tapin` (permission `administer tapin configuration`, `restrict access: true`).
- **REST resources (cookie auth):** `get_token_tapin` (`GET /api/tapin-gettokenrestresource`), `get_order_rest_resource` (`POST /api/tapin/get-order`), `tapin_update_order` (`POST /api/tapin/update-order`).
- **Routes:** `/admin/config/system/tapin/main` (`access order page`); `/admin/config/system/tapin/list` (**`access content`**, React shell).
- **Fields added:** `field_tapin_order_id`, `field_tapin_check`, `field_barcode_tapin` on commerce_order.

**Security:** REST resources require core `restful <method> <id>` permissions (not anonymous by default) but the handlers are unhardened — `get-order` returns customer PII for all fulfilment orders and `update-order` mutates any order by client-supplied `order_id` with no ownership check and no null-guard (`src/tapinService.php:128`). `get_token_tapin` returns a stored token. Grant these permissions only to the trusted tapin service account. See observations.

See [api/rest.md](api/rest.md)
