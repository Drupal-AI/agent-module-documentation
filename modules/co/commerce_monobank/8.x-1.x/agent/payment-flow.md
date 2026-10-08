<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commerce_monobank — payment flow

Source: `src/PluginForm/OffsiteRedirect/MonobankPaymentForm.php`. Constants: `TEST_API_URL =
https://api.monobank.ua/`, `CCY = 980` (UAH). API base is chosen by `getApiUrl()` — the admin
`action_url` in **Live** mode, otherwise `TEST_API_URL`.

## 1. Invoice creation and redirect (checkout → Monobank)

In `buildConfigurationForm()`:

1. Computes `amount = (int)(order total × 100)` from `order->getTotalPrice()` — **server-side**,
   currency `980`.
2. Builds `merchantPaymInfo.basketOrder` from the order items (title, qty, per-line sum with any
   first adjustment percentage applied, item id as `code`) and `reference = order id`.
3. `POST {api}api/merchant/invoice/create` with JSON body and headers
   `X-Token: <trimmed x_token>`, `X-Cms: Drupal CMS`, `X-Cms-Version: 9`, via
   `\Drupal::httpClient()` (Guzzle; default TLS verification on).
4. On success, reads `pageUrl` and `invoiceId` from the response. The `invoiceId` is written to
   `commerce_order.field_invoiceid_monobank` for that order (only if the column is still empty),
   binding the order to exactly one invoice.
5. Redirects the browser to Monobank's hosted `pageUrl`.

Errors from the HTTP call are caught and surfaced as a messenger error and logged to the
`commerce_monobank` channel.

## 2. Return and confirmation (Monobank → checkout)

When the buyer returns from Monobank, the form build detects the return and calls
`checkPaymentStatus($order)`:

1. Loads the stored `field_invoiceid_monobank` for the order.
2. `GET {api}api/merchant/invoice/status?invoiceId=<stored id>` with the same authenticated
   `X-Token` headers — an **authoritative server-to-server re-fetch**, not a value taken from the
   browser.
3. Only when the authoritative response has `status == 'success'`:
   - sets the order state and creates a Commerce `payment_default` payment in state `complete`
     for the **order's own total** (`amount => $order->getTotalPrice()`), then
   - calls `getFiscalChecks()` → `GET api/merchant/invoice/fiscal-checks?invoiceId=…` and emails
     the fiscal receipt link (`hook_mail`, key `commerce_monobank_complete_order`).
4. Any non-success status is logged/shown as a warning; the order is not completed.

Because the invoice id is server-stored and the completing amount is the order total, the buyer
cannot influence the paid state or amount from the return request — the decision rests on
Monobank's authenticated status response.

## Data model

`hook_install()` adds column `field_invoiceid_monobank varchar(255)` to `commerce_order`. This is a
plain schema column (added via the database schema API), not a Field API field. `hook_uninstall()`
is not implemented, so the column persists after uninstall.
