# Configuration

Commerce DIAS is configured entirely on the payment‑gateway form — there is no
separate settings page.

## Add the gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Choose the **DIAS Payment Redirect** plugin.

## Fill in the fields

All four fields come from your DIAS bank agreement:

- **Order registration API URL** — the DIAS endpoint the module calls to
  register an order and obtain the bank `formUrl` the shopper is redirected to.
- **Get order status API URL** — the DIAS endpoint the module polls to read an
  order's status when the shopper returns, and again from cron.
- **Username** — the merchant username supplied by the bank.
- **Password** — the merchant password supplied by the bank.

The store's default language is passed to DIAS as the payment language, and the
currency is **fixed to EUR** (currency code `978`) in the redirect form — this
gateway is euro‑only.

> **Gateway machine name.** The module's callback and cron code look the gateway
> up by a hard‑coded machine id (`dias_payment`). Give the gateway that machine
> name when you create it, or the return callback and the stale‑order cron will
> not find its configuration.

Click **Save**. The method is now available at checkout; place a test order and
confirm the shopper is POST‑redirected to the bank's `formUrl` and that a
completed payment is recorded on a successful return.

## How a payment completes

When the shopper returns, an anonymous callback route re‑queries the DIAS
**get‑order‑status** API and only records a **completed** payment when DIAS
reports success (`errorCode == 0`, `orderStatus == 2`, `actionCode == 0`). The
payment amount is read server‑side from the order balance, **not** from anything
the browser sends back, and a cron job resets the checkout step of unpaid draft
DIAS orders older than 15 minutes so abandoned attempts don't get stuck.

## Caveat to plan for

Understand this before taking real money.

- **Whole‑euro amounts.** The amount sent to DIAS is computed as an integer
  number of euros times 100, which truncates fractional (cent) amounts. Confirm
  this matches how you price products before relying on it.
