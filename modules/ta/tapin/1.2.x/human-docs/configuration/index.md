# Configuration

tapin needs to be configured before the external tapin service can talk to it.
There are two parts: the settings form (where you store the integration token and
related options), and the permissions grid (where you decide *which user* the
tapin service authenticates as). Getting the permissions right is the most
important security step on this page — please read the access notes below.

## Open the settings form

1. Log in as a user with the **Administer tapin configuration** permission (this
   is a *restricted* permission — grant it to administrators only).
2. Go to **Configuration → System → tapin**, or navigate directly to
   `/admin/config/system/tapin`.

Fill in the integration token and any other options the form presents, then save.
The token you store here is the value returned by the
`GET /api/tapin-gettokenrestresource` endpoint, so treat it as a shared secret
between your site and the tapin service.

## Grant the REST permissions — to the right user only

tapin's endpoints are protected by core REST permissions, which are *not* granted
to anonymous users by default. You control access from
**People → Permissions** (`/admin/people/permissions`). The relevant permissions
are the core `restful get|post <resource>` permissions for tapin's three
resources, plus the module's own:

| Permission | Give it to | Why |
|------------|-----------|-----|
| **Administer tapin configuration** (restricted) | Administrators only | Access to the settings form and the stored token. |
| **Access order page** | Trusted fulfilment staff | Access to the staff order screen at `/admin/config/system/tapin/main`. |
| `restful get get_token_tapin` | The tapin service account only | Returns the stored secret token — grant sparingly. |
| `restful post get_order_rest_resource` | The tapin service account only | Returns pending fulfilment orders **including customer personal data**. |
| `restful post tapin_update_order` | The tapin service account only | Marks any order id checked and writes back the barcode. |

**Important security notes.** The `get-order` response includes customer profile
data — name, mobile number, address, city, postal code — for every matching
order, with no per-order ownership filtering. The `update-order` endpoint loads
whatever `order_id` it is handed and marks it checked, again with no ownership
check. Because of this, the three `restful …` permissions must be granted **only**
to a single dedicated service account that represents the trusted tapin
integration — never to anonymous users, general customers, or broad roles. Create
a purpose-built Drupal user for the tapin service and give it just those
permissions.

## How the endpoints behave

- **`GET /api/tapin-gettokenrestresource`** — returns the stored token so the
  tapin service can confirm it is talking to the right site.
- **`POST /api/tapin/get-order`** — send a JSON body of
  `{ "page": 0, "limit": 10, "order_id": null }`. It returns orders in the
  `fulfillment` state whose `field_tapin_check` is `0`, newest first, with paging
  metadata and the billing profile for each order. Set `order_id` to a specific
  order number to fetch just that one.
- **`POST /api/tapin/update-order`** — send
  `{ "order_id": …, "barcode": "…", "field_tapin_order_id": "…" }`. It stores the
  barcode on `field_barcode_tapin`, sets `field_tapin_check` to `1`, and records
  the external tapin order id.

## The order screens

Staff with **Access order page** can use the screen at
`/admin/config/system/tapin/main`, and the React-based order dashboard renders at
`/admin/config/system/tapin/list`, where the fulfilment queue and barcode/QR
scanning workflow surface in the browser.
