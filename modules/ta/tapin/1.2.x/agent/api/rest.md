<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# tapin REST endpoints

All three resources are declared as config in `config/install/rest.resource.*.yml` with `authentication: [cookie]` and JSON format. Access additionally requires the core REST permission for the method/plugin (e.g. `restful post tapin_update_order`).

## GET /api/tapin-gettokenrestresource  (`get_token_tapin`)
Returns `{"token": <tapin.settings:token>}` — the stored integration token. Grant `restful get get_token_tapin` sparingly; it discloses a secret.

## POST /api/tapin/get-order  (`get_order_rest_resource`)
Body: `{ "page": 0, "limit": 10, "order_id": <order_number|null> }`.
Returns pending orders where state = `fulfillment` and `field_tapin_check = 0`, newest first, with paging metadata. Each item includes the billing profile (country, first/last name, mobile, address, province, city, postal code) and the first order item (product id, quantity, title). Note: the response exposes customer PII for every matching order with no per-order ownership filtering.

## POST /api/tapin/update-order  (`tapin_update_order`)
Body: `{ "order_id": <id>, "barcode": <string>, "field_tapin_order_id": <string> }`.
Loads the commerce_order by the client-supplied `order_id`, sets `field_barcode_tapin`, `field_tapin_check = 1`, and `field_tapin_order_id`, then saves. There is no ownership/state validation and no null check on the loaded order (`src/tapinService.php:128-137`), so any holder of `restful post tapin_update_order` can mark any order id checked (and a bad id fatals). Treat the permission as trusted-service-only.

Operational setup: enable the REST resources, create a dedicated service user, grant only the needed `restful …` permissions to it, and configure the settings form at `/admin/config/system/tapin`.
